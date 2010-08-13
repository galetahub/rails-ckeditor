class CkeditorMigrationGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      create_models(m)
      create_migration(m)
    end
  end

  protected
    
    def create_models(m)
      m.directory(File.join('app', 'models', ckeditor_dir))
      
      m.template "models/#{generator_dir}/asset.rb",
               File.join('app/models', ckeditor_dir, "asset.rb")
      
      m.template "models/#{generator_dir}/picture.rb",
               File.join('app/models', ckeditor_dir, "picture.rb")
      
      m.template "models/#{generator_dir}/attachment_file.rb",
               File.join('app/models', ckeditor_dir, "attachment_file.rb")
    end
    
    def create_migration(m)
      m.migration_template "models/#{generator_dir}/migration.rb", 'db/migrate', :migration_file_name => "create_ckeditor_assets.rb"
    end
      
    def ckeditor_dir
      'ckeditor'
    end
    
    def generator_dir
      options[:backend] || "paperclip"
    end
end
