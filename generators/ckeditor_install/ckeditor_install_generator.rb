require 'fileutils'

class CkeditorInstallGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      copy_initializer(m)
      copy_javascripts(m)
      
      m.readme "README"
    end
  end

  private
  
    def copy_initializer(m)
      m.directory "config/initializers"
      m.template  "ckeditor.rb", "config/initializers/ckeditor.rb"
    end
    
    def copy_javascripts(m)
      src_dir = File.join(@source_root, 'ckeditor')
      dst_dir = File.join(RAILS_ROOT, 'public', 'javascripts')
      
      FileUtils.cp_r src_dir, dst_dir, :verbose => true
    end

end
