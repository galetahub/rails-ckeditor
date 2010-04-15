require 'ckeditor/config'
require 'ckeditor/utils'
require 'ckeditor/view_helper'
require 'ckeditor/form_builder'

ActionView::Base.send(:include, Ckeditor::ViewHelper)
ActionView::Helpers::FormBuilder.send(:include, Ckeditor::FormBuilder)

ActionView::Helpers::AssetTagHelper.register_javascript_expansion :ckeditor => ["ckeditor/ckeditor"]

module ActionDispatch::Routing
  class Mapper
    def ckeditor_routes
      match 'ckeditor/images', :to => 'ckeditor#images'
      match 'ckeditor/files',  :to => 'ckeditor#files'
      match 'ckeditor/create', :to => 'ckeditor#create'
    end
  end
end

#Rails.application.routes.send("ckeditor_routes")

#Rails.application.routes.draw do |map|
#  match 'ckeditor/images', :to => 'ckeditor#images'
#  match 'ckeditor/files',  :to => 'ckeditor#files'
#  match 'ckeditor/create', :to => 'ckeditor#create'
#end

# Inside your routes (TODO: fix it):
# Demo::Application.routes.draw do |map|
#   ...
#   ckeditor_routes
#   ...
# end
