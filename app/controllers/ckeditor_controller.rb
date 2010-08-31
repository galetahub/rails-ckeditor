class CkeditorController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]
  before_filter :swf_options, :only => [:images, :files, :create]
  layout "ckeditor"
  
  # GET /ckeditor/images
  def images
    @images = Ckeditor.image_model.find(:all, :order=>"id DESC")
    
    respond_to do |format|
      format.html {}
      format.xml { render :xml=>@images }
    end
  end
  
  # GET /ckeditor/files
  def files
    @files = Ckeditor.file_model.find(:all, :order=>"id DESC")
    
    respond_to do |format|
      format.html {}
      format.xml { render :xml=>@files }
    end
  end
  
  # POST /ckeditor/create/:kind
  def create
    @kind = params[:kind] || 'file'
    
    unless params[:CKEditor].blank?	  
	    params[@swf_file_post_name] = params.delete(:upload)
	  end
	  
    klass = case @kind.downcase
      when 'file'  then Ckeditor.file_model
			when 'image' then Ckeditor.image_model
	  end
  
	  @record = klass.new
	  
	  options = {}
	  
	  params.each do |k, v|
	    key = k.to_s.downcase
	    options[key] = v if @record.respond_to?("#{key}=")
	  end
    
    @record.attributes = options
    @record.user ||= current_user if respond_to?(:current_user)
    
    if @record.valid? && @record.save
      @text = params[:CKEditor].blank? ? @record.to_json(:only=>[:id, :type], :methods=>[:url, :content_type, :size, :filename, :format_created_at], :root => "asset") : %Q"<script type='text/javascript'>
        window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{Ckeditor::Utils.escape_single_quotes(@record.url_content)}');
      </script>"
      
      render :text => @text
    else
      render :nothing => true
    end
  end

  private
    
    def swf_options
      @swf_file_post_name = Ckeditor.swf_file_post_name
      
      if params[:action] == 'images'
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
end
