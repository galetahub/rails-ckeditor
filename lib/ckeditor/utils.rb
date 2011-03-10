require 'fileutils'
require 'net/http'
require 'uri'

module Ckeditor
  module Utils
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
      
      def download(url, output)
        uri = URI.parse(url)
        file = File.open(output, 'w')
        
        Net::HTTP.start(uri.host, uri.port) do |http|
          begin
            http.request_get(uri.path) do |resp|
              resp.read_body { |segment| file.write(segment) }
            end
          ensure
            file.close
          end
        end
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
