class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
                    :url => "/ckeditor_assets/attachments/:id/:filename",
                    :path => ":rails_root/public/ckeditor_assets/attachments/:id/:filename"
  
  validates_attachment_size :data, :less_than=>100.megabytes
  
  def url(*args)
    if [:thumb, :content].include?(args.first)
      send("url_#{args.first}")
    else
      data.url(*args)
    end
  end
  
  def url_content
	  data.url
	end
	
	def url_thumb
	  extname = File.extname(filename)
    
    case extname.to_s
      when '.swf' then '/javascripts/ckeditor/images/swf.gif'
      when '.pdf' then '/javascripts/ckeditor/images/pdf.gif'
      when '.doc', '.txt' then '/javascripts/ckeditor/images/doc.gif'
      when '.mp3' then '/javascripts/ckeditor/images/mp3.gif'
      when '.rar', '.zip', '.tg' then '/javascripts/ckeditor/images/rar.gif'
      when '.xls' then '/javascripts/ckeditor/images/xls.gif'
      else '/javascripts/ckeditor/images/ckfnothumb.gif'
    end
	end
	
	def to_json(options = {})
	  options[:methods] ||= []
	  options[:methods] << :url_content
	  options[:methods] << :url_thumb
	  super options
  end
end
