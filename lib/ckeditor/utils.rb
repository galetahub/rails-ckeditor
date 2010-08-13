require 'fileutils'

module Ckeditor
  module Utils
    CKEDITOR_INSTALL_DIRECTORY = File.join(RAILS_ROOT, '/public/javascripts/ckeditor/')
    
    ##################################################################
    # remove the existing install (if any)
    def  self.destroy
      if File.exist?(CKEDITOR_INSTALL_DIRECTORY)
        FileUtils.rm_r(CKEDITOR_INSTALL_DIRECTORY)
      end
    end
    
    def self.escape_single_quotes(str)
      str.gsub('\\','\0\0').gsub('</','<\/').gsub(/\r\n|\n|\r/, "\\n").gsub(/["']/) { |m| "\\#{m}" }
    end
  end
end
