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
  end
end
