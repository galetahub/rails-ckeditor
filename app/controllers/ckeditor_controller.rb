class CkeditorController < ActionController::Base
  before_filter :swf_file_name, :only=>[:images, :create]
  
  layout false
  
  # GET /ckeditor/images
  def images
    @images = Picture.find(:all, :order=>"id DESC")
    
    respond_to do |format|
      format.html {}
      format.xml { render :xml=>@images }
    end
  end
  
  # POST /ckeditor/create
  def create
    @kind = params[:kind] || 'file'
    
    @record = case @kind.downcase
      when 'file'  then Attachment.new
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
    
    respond_to do |format|
      if @record.valid? && @record.save
        
        @text = params[:CKEditor].blank? ? @record.to_json : %Q"<script type='text/javascript'>
	        window.parent.CKEDITOR.tools.callFunction(#{params[:CKEditorFuncNum]}, '#{escape_single_quotes(@record.url(:content))}');
	      </script>"
        
        format.html { render :text=>@text }
        format.xml { head :ok }
      else
        format.html { render :nothing => true }
        format.xml { render :xml => @record.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
    
    def swf_file_name
      @swf_file_post_name = Ckeditor::Config.exists? ? Ckeditor::Config['swf_file_post_name'] : 'data'
    end
    
    def escape_single_quotes(str)
      str.gsub('\\','\0\0').gsub('</','<\/').gsub(/\r\n|\n|\r/, "\\n").gsub(/["']/) { |m| "\\#{m}" }
    end
  
end
