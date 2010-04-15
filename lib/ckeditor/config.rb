require 'yaml'

module Ckeditor
	class Config
		cattr_accessor :filepath
  	@@filepath = Rails.root.join("config", "ckeditor.yml")
    
  	@@available_settings = (File.exists?(@@filepath) ? YAML::load(File.open(@@filepath))[Rails.env] : nil)
  	
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
		end
	end
end
