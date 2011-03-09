module Ckeditor
  autoload :ViewHelper,        'ckeditor/view_helper'
  autoload :FormBuilder,       'ckeditor/form_builder'
  autoload :CustomFormBuilder, 'ckeditor/formtastic'
  autoload :Middleware,        'ckeditor/middleware'
  autoload :Utils,             'ckeditor/utils'
  
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
  @@file_manager_uri = "/ckeditor/attachments"
  
  mattr_accessor :file_manager_upload_uri
  @@file_manager_upload_uri = "/ckeditor/attachments"
  
  mattr_accessor :file_manager_image_upload_uri
  @@file_manager_image_upload_uri = "/ckeditor/pictures"
  
  mattr_accessor :file_manager_image_uri
  @@file_manager_image_uri = "/ckeditor/pictures"
  
  IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/tiff', 'image/x-png']
  
  # Get the image class from the image reference object.
  def self.image_model
    if self.class_variables.include?('@@image_model_ref')
      @@image_model_ref.get 
    else
      self.file_manager_image_model = "Ckeditor::Picture"
      @@image_model_ref.get
    end
  end
  
  # Set the image model reference object to access the images.
  def self.file_manager_image_model=(class_name)
    @@image_model_ref = ActiveSupport::Dependencies.ref(class_name)
  end
  
  # Get the file class from the file reference object.
  def self.file_model
    if self.class_variables.include?('@@file_model_ref')
      @@file_model_ref.get 
    else
      self.file_manager_file_model = "Ckeditor::AttachmentFile"
      @@file_model_ref.get
    end
  end
  
  # Set the file model reference object to access the files.
  def self.file_manager_file_model=(class_name)
    @@file_model_ref = ActiveSupport::Dependencies.ref(class_name)
  end
  
  # Default way to setup Ckeditor. Run rails generate ckeditor to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end

require 'ckeditor/engine'
