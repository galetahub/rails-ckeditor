# Use this hook to configure ckeditor
if Object.const_defined?("Ckeditor")
  Ckeditor.setup do |config|
    # The file_post_name allows you to set the value name used to post the file. 
    # This is not related to the file name. The default value is 'data'. 
    # For maximum compatibility it is recommended that the default value is used.
    #config.swf_file_post_name = "data"

    # A text description that is displayed to the user in the File Browser dialog. 
    #config.swf_file_types_description = "Files"

    # The file_types setting accepts a semi-colon separated list of file extensions 
    # that are allowed to be selected by the user. Use '*.*' to allow all file types.
    #config.swf_file_types = "*.doc;*.wpd;*.pdf;*.swf;*.xls"

    # The file_size_limit setting defines the maximum allowed size of a file to be uploaded. 
    # This setting accepts a value and unit. Valid units are B, KB, MB and GB. 
    # If the unit is omitted default is KB. A value of 0 (zero) is interpreted as unlimited.
    # Note: This setting only applies to the user's browser. It does not affect any settings or limits on the web server. 
    #config.swf_file_size_limit = "10 MB"
     
    # Defines the number of files allowed to be uploaded by SWFUpload. 
    # This setting also sets the upper bound of the file_queue_limit setting. 
    # Once the user has uploaded or queued the maximum number of files she will 
    # no longer be able to queue additional files. The value of 0 (zero) is interpreted as unlimited. 
    # Only successful uploads (uploads the trigger the uploadSuccess event) are counted toward the upload limit. 
    # The setStats function can be used to modify the number of successful uploads.
    # Note: This value is not tracked across pages and is reset when a page is refreshed. 
    # File quotas should be managed by the web server.
    #config.swf_file_upload_limit = 5
     
    # The same as for downloads files, only to upload images
    #config.swf_image_file_types_description = "Images"
    #config.swf_image_file_types = "*.jpg;*.jpeg;*.png;*.gif"
    #config.swf_image_file_size_limit = "5 MB"
    #config.swf_image_file_upload_limit = 10
    
    # Path for view all uploaded files
    #config.file_manager_uri = "/ckeditor/attachments"
    
    # Path for upload files process
    #config.file_manager_upload_uri = "/ckeditor/attachments"
    
    # Path for view all uploaded images
    #config.file_manager_image_uri = "/ckeditor/pictures"
    
    # Path for upload images process
    #config.file_manager_image_upload_uri = "/ckeditor/pictures"
   
    # Model's names witch processing in ckeditor_controller
    #config.file_manager_image_model = "Ckeditor::Picture"
    #config.file_manager_file_model = "Ckeditor::AttachmentFile"
  end
end
