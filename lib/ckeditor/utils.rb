# encoding: utf-8
require 'fileutils'
require 'open-uri'
require 'digest/sha1'
require 'mime/types'

module Ckeditor
  module Utils
    # RemoteFile
    # 
    # remote_file = RemoteFile.new("http://www.google.com/intl/en_ALL/images/logo.gif")
    # remote_file.original_filename #=> logo.gif
    # remote_file.content_type #= image/gif
    #
    class RemoteFile < ::Tempfile

      def initialize(path, tmpdir = Dir::tmpdir)
        @original_filename  = File.basename(path)
        @remote_path        = path
     
        super Digest::SHA1.hexdigest(path), tmpdir
        fetch
      end
     
      def fetch
        string_io = OpenURI.send(:open, @remote_path)
        body = string_io.read
        
        # Fix for ruby 1.9.2 (ASCII-8BIT and UTF-8 in hell issue)
        if body && body.respond_to?(:encoding) && body.encoding.name == 'ASCII-8BIT'
          body.force_encoding('UTF-8')
        end
        
        self.write body
        self.rewind
        self
      end
     
      def original_filename
        @original_filename
      end
     
      def content_type
        types = MIME::Types.type_for(self.path)
    	  types.empty? ? extract_content_type : types.first.to_s
      end
      
      protected
        
        def extract_content_type
          mime = `file --mime -br #{self.path}`.strip
          mime = mime.gsub(/^.*: */,"")
          mime = mime.gsub(/;.*$/,"")
          mime = mime.gsub(/,.*$/,"")
          mime
        end
    end
  
    class << self
      # remove the existing install (if any)
      def destroy
        directory = Rails.root.join('public', 'javascripts', 'ckeditor')
        if File.exist?(directory)
          FileUtils.rm_r(directory, :force => true)
        end
      end
      
      def escape_single_quotes(str)
        str.gsub('\\','\0\0').gsub('</','<\/').gsub(/\r\n|\n|\r/, "\\n").gsub(/["']/) { |m| "\\#{m}" }
      end
      
      def parameterize_filename(filename)
        extension = File.extname(filename)
        basename = filename.gsub(/#{extension}$/, "")
        
        [basename.parameterize('_'), extension].join.downcase
      end
      
      def download(url)
        RemoteFile.new(url)
      end
      
      def extract(filepath, output)
        # TODO: need check system OS
        system("tar --exclude=*.php --exclude=*.asp -C '#{output}' -xzvf '#{filepath}' ckeditor/")
      end
      
      def clear_dir(dirpath)
        FileUtils.rm_r(dirpath, :force => true)
        FileUtils.mkdir_p(dirpath)
      end
      
    end
  end
end
