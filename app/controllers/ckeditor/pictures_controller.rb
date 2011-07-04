class Ckeditor::PicturesController < Ckeditor::BaseController

  def index
    if Ckeditor.file_manager_partition_users and respond_to?(:current_user)
      @pictures = Ckeditor.image_model.where(:user_id => current_user).order("id DESC")
    else
      @pictures = Ckeditor.image_model.order("id DESC")
    end
    respond_with(@pictures)
  end

  def create
    @picture = Ckeditor.image_model.new
	  respond_with_asset(@picture)
  end

  def destroy
    @picture.destroy
    respond_with(@picture, :location => ckeditor_pictures_path)
  end

  protected

    def find_asset
      @picture = Ckeditor.image_model.find(params[:id])
    end
end
