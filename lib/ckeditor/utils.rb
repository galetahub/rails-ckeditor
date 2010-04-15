require 'fileutils'

module Ckeditor
  module Utils
    CKEDITOR_INSTALL_DIRECTORY = Rails.root.join('/public/javascripts/ckeditor/')

    ##################################################################
    # remove the existing install (if any)
    def  self.destroy
      if File.exist?(CKEDITOR_INSTALL_DIRECTORY)
        FileUtils.rm_r(CKEDITOR_INSTALL_DIRECTORY)
      end
    end
  end
end
