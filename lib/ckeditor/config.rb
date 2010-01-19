module Ckeditor

	class Config
		cattr_accessor :filepath
  	@@filepath = File.join(RAILS_ROOT, "config/ckeditor.yml")
    
  	@@available_settings = (File.exists?(@@filepath) ? YAML::load(File.open(@@filepath))[RAILS_ENV] : nil)
  	
  	class << self
  	
			def [](name)
				return if @@available_settings.nil?
				@@available_settings[name.to_s]
			end
		
			def method_missing(method, *args)
				method_name = method.to_s
				return self[method_name].to_s if !@@available_settings.nil? && @@available_settings.keys.include?(method_name)
				super
			end
			
			def exists?
				File.exists?(@@filepath)
			end
			
			def create_yml
        unless File.exists?(@@filepath)
          ck_config = File.join(RAILS_ROOT, 'vendor/plugins/rails-ckeditor/', 'ckeditor.yml.tpl')
          FileUtils.cp ck_config, @@filepath unless File.exist?(@@filepath)
          
          log "#{@@filepath} example file created!"
          log "Please modify your settings"
        else
          log "config/#{@@filepath} already exists. Aborting task..."
        end
      end
			
			def log(message)
        STDOUT.puts message
      end
		end
	end
end
