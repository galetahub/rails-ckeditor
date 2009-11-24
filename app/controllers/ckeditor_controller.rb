class CkeditorController < ActionController::Base
  before_filter :swf_options, :only=>[:images, :files, :create]
  
  layout "ckeditor"
  
  # GET /ckeditor/images
  def images
    @images = Picture.find(:all, :order=>"id DESC")
    
    respond_to do |format|
      format.html {}
      format.xml { render :xml=>@images }
    end
  end
  
  # GET /ckeditor/files
  def files
    @files = AttachmentFile.find(:all, :order=>"id DESC")
    
    respond_to do |format|
      format.html {}
      format.xml { render :xml=>@files }
    end
  end
  
  # POST /ckeditor/create
  def create
    @kind = params[:kind] || 'file'
    
    @record = case @kind.downcase
      when 'file'  then AttachmentFile.new
			when 'image' then Picture.new
	  end
	  
	  unless params[:CKEditor].blank?	  
	    params[@swf_file_post_name] = params.delete(:upload)
	  end
	  
	  options = {}
	  
	  params.each do |k, v|
	    key = k.to_s.downcase
	    options[key] = v if @record.respond_to?("#{key}=")
	  end
    
    @record.attributes = options
    
    if @record.valid? && @record.save
      @text = params[:CKEditor].blank? ? @record.to_json(:only=>[:id, :type], :methods=>[:url, :content_type, :size, :filename, :format_created_at]) : %Q"<script type='text/javascript'>
        window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{escape_single_quotes(@record.url(:content))}');
      </script>"
      
      render :text=>@text
    else
      render :nothing => true
    end
  end

  private
    
    def swf_options
      if Ckeditor::Config.exists?
        @swf_file_post_name = Ckeditor::Config['swf_file_post_name']
        
        if params[:action] == 'images'
          @file_size_limit = Ckeditor::Config['swf_image_file_size_limit']
				  @file_types = Ckeditor::Config['swf_image_file_types']
				  @file_types_description = Ckeditor::Config['swf_image_file_types_description']
				  @file_upload_limit = Ckeditor::Config['swf_image_file_upload_limit']
			  else
			    @file_size_limit = Ckeditor::Config['swf_file_size_limit']
			    @file_types = Ckeditor::Config['swf_file_types']
			    @file_types_description = Ckeditor::Config['swf_file_types_description']
			    @file_upload_limit = Ckeditor::Config['swf_file_upload_limit']
			  end
      end
      
      @swf_file_post_name ||= 'data'
      @file_size_limit ||= "5 MB"
      @file_types ||= "*.jpg;*.jpeg;*.png;*.gif"
      @file_types_description ||= "Images"
      @file_upload_limit ||= 10
    end
    
    def escape_single_quotes(str)
      str.gsub('\\','\0\0').gsub('</','<\/').gsub(/\r\n|\n|\r/, "\\n").gsub(/["']/) { |m| "\\#{m}" }
    end
  
end
