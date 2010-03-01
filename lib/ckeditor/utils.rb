module Ckeditor
  module Utils
    CKEDITOR_INSTALL_DIRECTORY = File.join(RAILS_ROOT, '/public/javascripts/ckeditor/')
    PLUGIN_INSTALL_DIRECTORY =  File.join(RAILS_ROOT, '/vendor/plugins/rails-ckeditor/')

    def self.recursive_copy(options)
      source = options[:source]
      dest = options[:dest]
      logging = options[:logging].nil? ? true : options[:logging]

      Dir.foreach(source) do |entry|
        next if entry =~ /^(\.|_)|(\.php)$/
        
        if File.directory?(File.join(source, entry))
          unless File.exist?(File.join(dest, entry))
            puts "Creating directory #{entry}..." if logging
            FileUtils.mkdir File.join(dest, entry)
          end
          recursive_copy(:source => File.join(source, entry),
                         :dest => File.join(dest, entry),
                         :logging => logging)
        else
          FileUtils.cp File.join(source, entry), File.join(dest, entry)
        end
      end
    end

    def self.backup_existing
      source = File.join(RAILS_ROOT,'/public/javascripts/ckeditor')
      dest = File.join(RAILS_ROOT,'/public/javascripts/ckeditor_bck')

      FileUtils.rm_r(dest) if File.exists? dest
      FileUtils.mv source, dest
    end

    def self.create_uploads_directory
      uploads = File.join(RAILS_ROOT, '/public/uploads')
      FileUtils.mkdir(uploads) unless File.exist?(uploads)
    end

    def self.install(log)
      directory = File.join(RAILS_ROOT, '/vendor/plugins/rails-ckeditor/')
      source = File.join(directory,'/public/javascripts/ckeditor/')
      FileUtils.mkdir(CKEDITOR_INSTALL_DIRECTORY)
      
      # recursively copy all our files over
      recursive_copy(:source => source, :dest => CKEDITOR_INSTALL_DIRECTORY, :logging => log)
    end

    ##################################################################
    # remove the existing install (if any)
    #
    def  self.destroy
      if File.exist?(CKEDITOR_INSTALL_DIRECTORY)
        FileUtils.rm_r(CKEDITOR_INSTALL_DIRECTORY)

        FileUtils.rm(File.join(RAILS_ROOT, '/public/javascripts/ckcustom.js')) \
        if File.exist? File.join(RAILS_ROOT, '/public/javascripts/ckcustom.js')
      end
    end

    def self.rm_plugin
      if File.exist?(PLUGIN_INSTALL_DIRECTORY)
        FileUtils.rm_r(PLUGIN_INSTALL_DIRECTORY)
      end
    end

    def self.destroy_and_install
      destroy
      # now install fresh
      install(true)
    end

    def self.check_and_install
      # check to see if already installed, if not install
      unless File.exist?(CKEDITOR_INSTALL_DIRECTORY)
        install(false)
      end
    end
  end
end
