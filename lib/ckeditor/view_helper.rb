module Ckeditor
  module ViewHelper
    include ActionView::Helpers
    
    # Ckeditor helper:
    # <%= ckeditor_textarea("object", "field", :width => '100%', :height => '200px') %>
    #
    # Two forms on one page:
    # <%= form_tag "one" %>
    #   <%= ckeditor_textarea("object", "field", :id => "demo1") %>
    # <% end %>
    # ...
    # <%= form_tag "two" %>
    #   <%= ckeditor_textarea("object", "field", :id => "demo2") %>
    # <% end %>
    #
    def ckeditor_textarea(object, field, options = {})
      options.symbolize_keys!
      
      var = options.delete(:object) if options.key?(:object)
      var ||= @template.instance_variable_get("@#{object}")
      
      value = var.send(field.to_sym) if var
      value ||= options[:value] || ""
      
      element_id = options[:id] || ckeditor_element_id(object, field)
      
      textarea_options = { :id => element_id }
      
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
      
      ckeditor_options[:filebrowserBrowseUrl] = Ckeditor.file_manager_uri
      ckeditor_options[:filebrowserUploadUrl] = Ckeditor.file_manager_upload_uri
      
      ckeditor_options[:filebrowserImageBrowseUrl] = Ckeditor.file_manager_image_uri
      ckeditor_options[:filebrowserImageUploadUrl] = Ckeditor.file_manager_image_upload_uri
      
      output_buffer = ActiveSupport::SafeBuffer.new
      
      textarea_options.update(:style => "width:#{width};height:#{height}")
        
      output_buffer << ActionView::Base::InstanceTag.new(object, field, self, var).to_text_area_tag(textarea_options)
      
      output_buffer << javascript_tag("CKEDITOR.replace('#{element_id}', { 
          #{ckeditor_applay_options(ckeditor_options)}
        });\n")
        
      output_buffer
    end
    
    def ckeditor_ajax_script(backend = 'jquery')
      javascript_tag("$(document).ready(function(){  
        $('form[data-remote]').bind('ajax:before', function(){
          for (instance in CKEDITOR.instances){
            CKEDITOR.instances[instance].updateElement();
          }
        });
      });")
    end
    
    protected
      
      def ckeditor_element_id(object, field)
        "#{object}_#{field}_editor"
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
