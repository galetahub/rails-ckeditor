class Ckeditor::AttachmentFilesController < Ckeditor::BaseController

  def index
    if Ckeditor.file_manager_partition_users and respond_to?(:current_user)
      @attachments = Ckeditor.file_model.where(:user_id => current_user).order("id DESC")
    else
      @attachments = Ckeditor.file_model.order("id DESC")
    end
    respond_with(@attachments)
  end

  def create
    if Ckeditor.file_manager_partition_users and respond_to?(:current_user)
      if Ckeditor.file_model.where(:user_id => current_user).count <= Ckeditor.swf_file_upload_limit
        @attachment = Ckeditor.file_model.new
      end
    else
      @attachment = Ckeditor.file_model.new
    end
	  respond_with_asset(@attachment)
  end

  def destroy
    @attachment.destroy
    respond_with(@attachment, :location => ckeditor_attachments_path)
  end

  protected

    def find_asset
      @attachment = Ckeditor.file_model.find(params[:id])
    end
end
