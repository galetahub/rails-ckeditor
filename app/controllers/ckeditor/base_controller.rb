class Ckeditor::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  
  before_filter :swf_options, :only => [:index, :create]
  before_filter :find_asset, :only => [:destroy]
  
  respond_to :html, :xml, :json
  
  layout "ckeditor"

  protected
    
    def swf_options
      @swf_file_post_name = Ckeditor.swf_file_post_name
      
      if params[:controller] == 'ckeditor/pictures'
        @file_size_limit        = Ckeditor.swf_image_file_size_limit
			  @file_types             = Ckeditor.swf_image_file_types
			  @file_types_description = Ckeditor.swf_image_file_types_description
			  @file_upload_limit      = Ckeditor.swf_image_file_upload_limit
		  else
		    @file_size_limit        = Ckeditor.swf_file_size_limit
		    @file_types             = Ckeditor.swf_file_types
		    @file_types_description = Ckeditor.swf_file_types_description
		    @file_upload_limit      = Ckeditor.swf_file_upload_limit
		  end
      
      @swf_file_post_name ||= 'data'
      @file_size_limit ||= "5 MB"
      @file_types ||= "*.jpg;*.jpeg;*.png;*.gif"
      @file_types_description ||= "Images"
      @file_upload_limit ||= 10
    end
    
    def respond_with_asset(record)
      unless params[:CKEditor].blank?	  
	      params[@swf_file_post_name] = params.delete(:upload)
	    end
	    
	    options = {}
	    
	    params.each do |k, v|
	      key = k.to_s.downcase
	      options[key] = v if record.respond_to?("#{key}=")
	    end
      
      record.attributes = options
      record.user ||= current_user if respond_to?(:current_user)
      
      if record.valid? && record.save
        body = params[:CKEditor].blank? ? record.to_json(:only=>[:id, :type], :methods=>[:url, :content_type, :size, :filename, :format_created_at], :root => "asset") : %Q"<script type='text/javascript'>
          window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{Ckeditor::Utils.escape_single_quotes(record.url_content)}');
        </script>"
        
        render :text => body
      else
        render :nothing => true
      end
    end
end
