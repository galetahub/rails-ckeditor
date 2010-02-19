module Ckeditor
  PLUGIN_NAME = 'rails-ckeditor'
  PLUGIN_PATH = File.join(RAILS_ROOT, "vendor/plugins", PLUGIN_NAME)
  
  PLUGIN_PUBLIC_PATH = Ckeditor::Config.exists? ? Ckeditor::Config['public_path'] : "#{RAILS_ROOT}/public/uploads"
  PLUGIN_PUBLIC_URI  = Ckeditor::Config.exists? ? Ckeditor::Config['public_uri'] : "/uploads"
  
  PLUGIN_CONTROLLER_PATH = File.join(PLUGIN_PATH, "/app/controllers")
  PLUGIN_VIEWS_PATH      = File.join(PLUGIN_PATH, "/app/views")
  PLUGIN_HELPER_PATH     = File.join(PLUGIN_PATH, "/app/helpers")
  
  PLUGIN_FILE_MANAGER_URI        = Ckeditor::Config.exists? ? Ckeditor::Config['file_manager_uri'] : ""
  PLUGIN_FILE_MANAGER_UPLOAD_URI = Ckeditor::Config.exists? ? Ckeditor::Config['file_manager_upload_uri'] : ""
  PLUGIN_FILE_MANAGER_IMAGE_URI  = Ckeditor::Config.exists? ? Ckeditor::Config['file_manager_image_uri'] : ""
  PLUGIN_FILE_MANAGER_IMAGE_UPLOAD_URI = Ckeditor::Config.exists? ? Ckeditor::Config['file_manager_image_upload_uri'] : ""

  module ViewHelper
    include ActionView::Helpers
    
    # Example:
    # <%= ckeditor_textarea("object", "field", :width => '100%', :height => '200px') %>
    #
    # To use a remote form you need to do something like this
    # <%= form_remote_tag :url => @options.merge(:controller => @scaffold_controller),
    #              :before => Ckeditor_before_js('note', 'text') %>
    #
    #   <%= ckeditor_textarea( "note", "text", :ajax => true ) %>
    #
    # <%= end_form_tag %>
    def ckeditor_textarea(object, field, options = {})
      options.symbolize_keys!
      
      var = options.delete(:object) if options.key?(:object)
      var ||= @template.instance_variable_get("@#{object}")
      
      value = var.send(field.to_sym) if var
      value ||= options[:value] || ""
      
      id = ckeditor_element_id(object, field)
      
      textarea_options = { :id => id }
      
      textarea_options[:cols] = options[:cols].nil? ? 70 : options[:cols].to_i
      textarea_options[:rows] = options[:rows].nil? ? 20 : options[:rows].to_i
      textarea_options[:class] = options[:class] unless options[:class].nil?

      width = options[:width].nil? ? '100%' : options[:width]
      height = options[:height].nil? ? '100%' : options[:height]
      
      ckeditor_options = {}
      
      ckeditor_options[:language] = options[:language] || I18n.locale.to_s
      ckeditor_options[:toolbar]  = options[:toolbar] unless options[:toolbar].nil?
      ckeditor_options[:skin]     = options[:skin]    unless options[:skin].nil?
      ckeditor_options[:width]    = options[:width]   unless options[:width].nil?
      ckeditor_options[:height]   = options[:height]  unless options[:height].nil?
      
      ckeditor_options[:swf_params] = options[:swf_params] unless options[:swf_params].nil?
      
      ckeditor_options[:filebrowserBrowseUrl] = PLUGIN_FILE_MANAGER_URI
      ckeditor_options[:filebrowserUploadUrl] = PLUGIN_FILE_MANAGER_UPLOAD_URI
      
      ckeditor_options[:filebrowserImageBrowseUrl] = PLUGIN_FILE_MANAGER_IMAGE_URI
      ckeditor_options[:filebrowserImageUploadUrl] = PLUGIN_FILE_MANAGER_IMAGE_UPLOAD_URI
      
      output_buffer = ActionView::SafeBuffer.new
      
      if options[:ajax]
        textarea_options.update(:name => id)
        
        output_buffer << tag(:input, { "type" => "hidden", "name" => "#{object}[#{field}]", "id" => "#{id}_hidden"})
        output_buffer << ActionView::Base::InstanceTag.new(object, field, self, var).to_text_area_tag(textarea_options)
      else
        textarea_options.update(:style => "width:#{width};height:#{height}")
        
        output_buffer << ActionView::Base::InstanceTag.new(object, field, self, var).to_text_area_tag(textarea_options)
      end
      
      output_buffer << javascript_tag("CKEDITOR.replace('#{object}[#{field}]', { 
          #{ckeditor_applay_options(ckeditor_options)}
        });\n")
        
      output_buffer
    end

    def ckeditor_form_remote_tag(options = {})
      editors = options[:editors]
      before = ""
      editors.keys.each do |e|
        editors[e].each do |f|
          before += ckeditor_before_js(e, f)
        end
      end
      options[:before] = options[:before].nil? ? before : before + options[:before]
      form_remote_tag(options)
    end

    def ckeditor_remote_form_for(object_name, *args, &proc)
      options = args.last.is_a?(Hash) ? args.pop : {}
      concat(ckeditor_form_remote_tag(options), proc.binding)
      fields_for(object_name, *(args << options), &proc)
      concat('</form>', proc.binding)
    end
    alias_method :ckeditor_form_remote_for, :ckeditor_remote_form_for

    def ckeditor_element_id(object, field)
      "#{object}_#{field}_editor"
    end

    def ckeditor_div_id(object, field)
      id = eval("@#{object}.id")
      "div-#{object}-#{id}-#{field}-editor"
    end

    def ckeditor_before_js(object, field)
      id = ckeditor_element_id(object, field)
      "var oEditor = CKEDITOR.instances.#{id}.getData();"
    end
    
    def ckeditor_applay_options(options={})
      str = []
      options.each do |k, v|
        value = case v.class.to_s.downcase
          when 'string' then "'#{v}'"
          when 'hash' then "{ #{ckeditor_applay_options(v)} }"
          else v
        end
        str << "#{k}: #{value}"
      end
      
      str.join(',')
    end
  end
end
