unless ActiveSupport.const_defined?("SafeBuffer")
  require 'ckeditor/safe_buffer'
end

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
  
  # Get the image class from the image reference object.
  def self.image_model
    @@file_manager_image_model.to_s.classify.constantize
  end
  
  # Get the file class from the file reference object.
  def self.file_model
    @@file_manager_file_model.to_s.classify.constantize
  end
  
  # Default way to setup Ckeditor. Run rails generate ckeditor to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
  
  def self.insert
    ActionView::Base.send(:include, Ckeditor::ViewHelper)
    ActionView::Helpers::FormBuilder.send(:include, Ckeditor::FormBuilder)
    
    ActionView::Helpers::AssetTagHelper.register_javascript_expansion :ckeditor => ["ckeditor/ckeditor"]
    
    if Object.const_defined?("Formtastic")
      Formtastic::SemanticFormHelper.builder = Ckeditor::CustomFormBuilder
    end
  end
end
