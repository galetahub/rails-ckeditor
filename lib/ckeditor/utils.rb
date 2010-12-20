require 'fileutils'

module Ckeditor
  module Utils

    # remove the existing install (if any)
    def self.destroy
      directory = Rails.root.join('public', 'javascripts', 'ckeditor')
      if File.exist?(directory)
        FileUtils.rm_r(directory, :force => true)
      end
    end
    
    def self.escape_single_quotes(str)
      str.gsub('\\','\0\0').gsub('</','<\/').gsub(/\r\n|\n|\r/, "\\n").gsub(/["']/) { |m| "\\#{m}" }
    end
    
    def self.parameterize_filename(filename)
      extension = File.extname(filename)
      basename = filename.gsub(/#{extension}$/, "")
      
      [basename.parameterize('_'), extension].join.downcase
    end
    
  end
end
