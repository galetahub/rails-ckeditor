module Ckeditor
  autoload :ViewHelper, 'ckeditor/view_helper'
  autoload :FormBuilder, 'ckeditor/form_builder'
  
  mattr_accessor :swf_file_post_name
  @@swf_file_post_name = "data"
  
  mattr_accessor :swf_image_file_types_description
  @@swf_image_file_types_description = "Images"
  
  mattr_accessor :swf_image_file_types
  @@swf_image_file_types = "*.jpg;*.jpeg;*.png;*.gif"
  
  mattr_accessor :swf_image_file_size_limit
  @@swf_image_file_size_limit = "5 MB"
  
  mattr_accessor :swf_image_file_upload_limit
  @@swf_image_file_upload_limit = 10
  
  mattr_accessor :swf_file_types_description
  @@swf_file_types_description = "Files"
  
  mattr_accessor :swf_file_types
  @@swf_file_types = "*.doc;*.wpd;*.pdf;*.swf;*.xls"
  
  mattr_accessor :swf_file_size_limit
  @@swf_file_size_limit = "10 MB"
  
  mattr_accessor :swf_file_upload_limit
  @@swf_file_file_upload_limit = 5
  
  mattr_accessor :public_uri
  @@public_uri = "/uploads"
  
  mattr_accessor :public_path
  @@public_path = "public/uploads"
  
  mattr_accessor :file_manager_uri
  @@file_manager_uri = "/ckeditor/files"
  
  mattr_accessor :file_manager_upload_uri
  @@file_manager_upload_uri = "/ckeditor/create/file"
  
  mattr_accessor :file_manager_image_upload_uri
  @@file_manager_image_upload_uri = "/ckeditor/create/image"
  
  mattr_accessor :file_manager_image_uri
  @@file_manager_image_uri = "/ckeditor/images"
  
  mattr_accessor :file_manager_image_model
  @@file_manager_image_model = "Ckeditor::Picture"
  
  mattr_accessor :file_manager_file_model
  @@file_manager_file_model = "Ckeditor::AttachmentFile"
  
  def self.image_model
    @@image_model ||= @@file_manager_image_model.to_s.constantize
    @@image_model
  end
  
  def self.file_model
    @@file_model ||= @@file_manager_file_model.to_s.constantize
    @@file_model
  end
  
  # Default way to setup Ckeditor. Run rails generate ckeditor to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end

require 'ckeditor/engine'

if Object.const_defined?("Formtastic")
  require "ckeditor/formtastic"
end
