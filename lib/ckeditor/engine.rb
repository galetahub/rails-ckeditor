module Ckeditor
  class Engine < ::Rails::Engine
    config.after_initialize do
      ActionView::Base.send :include, Ckeditor::ViewHelper
      ActionView::Helpers::FormBuilder.send :include, Ckeditor::FormBuilder
      
      ActionView::Helpers::AssetTagHelper.register_javascript_expansion :ckeditor => ["ckeditor/ckeditor"]
    end
  end
end
