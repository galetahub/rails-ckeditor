class AttachmentFile < Asset
 
  # === List of columns ===
  # id : integer
  # data_file_name : string
  # data_content_type : string
  # data_file_size : integer
  # assetable_id : integer
  # assetable_type : string
  # type : string
  # locale : integer
  # user_id : integer
  # created_at : datetime
  # updated_at : datetime
  # =======================
 
  has_attached_file :data,
                    :s3_credentials => "#{Rails.root}/config/s3.yml", :bucket => "yourbucket",
                    :storage => :s3,
                    :path => "#{APP_NAME}/files/:id/:filename"
  
  validates_attachment_size :data, :less_than => 10.megabytes
end
