class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attachment :storage => :file_system, :path_prefix => 'public/assets/attachments',
                 :max_size => 10.megabytes
  
  validates_as_attachment
  
  # Map file extensions to mime types.
  # Thanks to bug in Flash 8 the content type is always set to application/octet-stream.
  # From: http://blog.airbladesoftware.com/2007/8/8/uploading-files-with-swfupload
  def swf_uploaded_data=(data)
    data.content_type = MIME::Types.type_for(data.original_filename)
    self.uploaded_data = data
  end
  
  def full_filename(thumbnail = nil)
    file_system_path = self.attachment_options[:path_prefix]
    Rails.root.join(file_system_path, file_name_for(self.id))
  end
  
  def file_name_for(asset = nil)
    extension = filename.scan(/\.\w+$/)
    return "#{asset}_#{filename}"
  end
end
