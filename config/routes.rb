Rails.application.routes.draw do
  namespace :ckeditor do
    resources :pictures, :only => [:index, :create, :destroy]
    resources :attachments, :only => [:index, :create, :destroy]
  end
end
