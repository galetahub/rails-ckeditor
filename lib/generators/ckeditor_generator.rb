require 'rails/generators'

class CkeditorGenerator < Rails::Generators::Base

  def self.source_root
    @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end  
  
  def copy_initializer
    template "ckeditor.rb", "config/initializers/ckeditor.rb"
  end
  
  # copy ckeditor files
  def install_ckeditor
    directory "ckeditor", "public/javascripts/ckeditor"
    
#    # copy configuration file
#    copy_file(
#      'ckeditor.yml',
#      'config/initializers/ckeditor.yml'
#    )
  end
end
