require 'rails/generators'

module Ckeditor
  class BaseGenerator < Rails::Generators::Base
    class_option :version, :type => :string, :default => '3.5.2',
                 :desc => "Version of ckeditor which be install"

    def self.source_root
      @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
    end  
    
    # copy configuration
    def copy_initializer
      template "ckeditor.rb", "config/initializers/ckeditor.rb"
    end
    
    # copy ckeditor files
    def install_ckeditor
      puts "Start download #{filename}"
      Ckeditor::Utils.download(download_url, filepath)
      
      if File.exist?(filepath)
        puts "Extract #{filepath}"
        Ckeditor::Utils.extract(filepath, Rails.root.join('public', 'javascripts'))
      
        directory "ckeditor", "public/javascripts/ckeditor"
        File.delete(filepath)
      else
        raise Rails::Generators::Error.new("Cannot download file #{download_url}")
      end
    end
    
    protected
    
      def download_url
        "http://download.cksource.com/CKEditor/CKEditor/CKEditor%20#{options[:version]}/ckeditor_#{options[:version]}.tar.gz"
      end
      
      def filename
        "ckeditor_#{options[:version]}.tar.gz"
      end
      
      def filepath
        Rails.root.join('tmp', filename)
      end
  end
end
