module Ckeditor::BaseHelper
  def ckeditor_attachment_path(kind)
    path = case kind
      when :image then Ckeditor.file_manager_image_upload_uri
      when :file  then Ckeditor.file_manager_upload_uri
      else '/ckeditor/attachments'
    end
    
    session_key = Rails.application.config.send(:session_options)[:key]
    
    options = Rails.application.routes.recognize_path(path, :method => :post)
    options[:protocol] = "http://"
    options[session_key] = Rack::Utils.escape(cookies[session_key])
    
    if protect_against_forgery?
      options[request_forgery_protection_token] = Rack::Utils.escape(form_authenticity_token)
    end
    
    url_for(options)
  end
end
