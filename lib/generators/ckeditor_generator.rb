require 'rails/generators'

class CkeditorGenerator < Rails::Generators::Base

  def self.source_root
    @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end  
  
  def install_ckeditor
    # copy ckeditor files
    directory "ckeditor", "public/javascripts/ckeditor"
    
    # copy configuration file
    copy_file(
      'ckeditor.yml',
      'config/ckeditor.yml'
    )
  end
end
