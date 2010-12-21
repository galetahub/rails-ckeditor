ActionController::Routing::Routes.draw do |map|
  map.connect 'ckeditor/images', :controller => 'ckeditor', :action => 'images'
  map.connect 'ckeditor/files',  :controller => 'ckeditor', :action => 'files'
  map.connect 'ckeditor/create/:kind', :controller => 'ckeditor', :action => 'create'
  map.connect 'ckeditor/:id', :controller => 'ckeditor', :action => 'destroy', :conditions => {:method => :delete}
end
