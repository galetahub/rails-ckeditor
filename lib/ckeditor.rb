require 'yaml'
require 'fileutils'
require 'tmpdir'

# Include hook code here
require 'ckeditor/config'
require 'ckeditor/utils'
require 'ckeditor/view_helper'
require 'ckeditor/form_builder'

unless defined?(ActionView::SafeBuffer)
  require 'ckeditor/safe_buffer'
end

ActionView::Base.send(:include, Ckeditor::ViewHelper)
ActionView::Helpers::FormBuilder.send(:include, Ckeditor::FormBuilder)

Ckeditor::Utils.check_and_install

class ActionController::Routing::RouteSet
  unless (instance_methods.include?('draw_with_ckeditor'))
    class_eval <<-"end_eval", __FILE__, __LINE__  
      alias draw_without_ckeditor draw
      def draw_with_ckeditor
        draw_without_ckeditor do |map|
          map.connect 'ckeditor/images', :controller => 'ckeditor', :action => 'images'
          map.connect 'ckeditor/files',  :controller => 'ckeditor', :action => 'files'
          map.connect 'ckeditor/create', :controller => 'ckeditor', :action => 'create'
          yield map
        end
      end
      alias draw draw_with_ckeditor
    end_eval
  end
end

include ActionView
module ActionView::Helpers::AssetTagHelper
  alias_method :rails_javascript_include_tag, :javascript_include_tag

  #  <%= javascript_include_tag :defaults, :ckeditor %>
  def javascript_include_tag(*sources)
    main_sources, application_source = [], []
    if sources.include?(:ckeditor)
      sources.delete(:ckeditor)
      sources.push('ckeditor/ckeditor')
    end
    unless sources.empty?
      main_sources = rails_javascript_include_tag(*sources).split("\n")
      application_source = main_sources.pop if main_sources.last.include?('application.js')
    end
    [main_sources.join("\n"), application_source].join("\n")
  end
end
