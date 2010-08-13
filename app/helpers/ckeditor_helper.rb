module CkeditorHelper
  def ckeditor_attachment_path(kind)
    path = case kind
      when :image then Ckeditor.file_manager_image_upload_uri
      when :file  then Ckeditor.file_manager_upload_uri
      else '/ckeditor/create/default'
    end
    
    session_key = ActionController::Base.session_options[:key]
    
    options = ActionController::Routing::Routes.recognize_path(path, :method => :post)
    
    options[:protocol] = "http://"
    options[session_key] = Rack::Utils.escape(cookies[session_key])
    
    if protect_against_forgery?
      options[request_forgery_protection_token] = Rack::Utils.escape(form_authenticity_token)
    end
    
    url_for(options)
  end
  
  def file_image_tag(filename, path)
    extname = File.extname(filename)
    
    image = case extname.to_s
      when '.swf' then '/javascripts/ckeditor/images/swf.gif'
      when '.pdf' then '/javascripts/ckeditor/images/pdf.gif'
      when '.doc', '.txt' then '/javascripts/ckeditor/images/doc.gif'
      when '.mp3' then '/javascripts/ckeditor/images/mp3.gif'
      when '.rar', '.zip', '.tg' then '/javascripts/ckeditor/images/rar.gif'
      when '.xls' then '/javascripts/ckeditor/images/xls.gif'
      else '/javascripts/ckeditor/images/ckfnothumb.gif'
    end
    
    image_tag(image, :alt=>path, :title=>filename, :onerror=>"this.src='/javascripts/ckeditor/images/ckfnothumb.gif'", :class=>'image')
  end
end
