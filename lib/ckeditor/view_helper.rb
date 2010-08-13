module Ckeditor
  module ViewHelper
    include ActionView::Helpers
    
    # Ckeditor helper:
    # <%= ckeditor_textarea("object", "field", :width => '100%', :height => '200px') %>
    #
    # Two forms on one page:
    # <%= form_tag "one" %>
    #   <%= ckeditor_textarea("object", "field", :index => "1") %>
    # <% end %>
    # ...
    # <%= form_tag "two" %>
    #   <%= ckeditor_textarea("object", "field", :index => "2") %>
    # <% end %>
    #
    def ckeditor_textarea(object, field, options = {})
      options = options.dup.symbolize_keys
      
      var = options.delete(:object) if options.key?(:object)
      var ||= @template.instance_variable_get("@#{object}")
      
      value = var.send(field.to_sym) if var
      value ||= options.delete(:value) || ""
      
      element_id = options.delete(:id) || ckeditor_element_id(object, field, options.delete(:index))
      width  = options.delete(:width) || '100%'
      height = options.delete(:height) || '100%'
      
      textarea_options = { :id => element_id }
      
      textarea_options[:cols]  = (options.delete(:cols) || 70).to_i
      textarea_options[:rows]  = (options.delete(:rows) || 20).to_i
      textarea_options[:class] = (options.delete(:class) || 'editor').to_s
      textarea_options[:style] = "width:#{width};height:#{height}"
      
      ckeditor_options = {:width => width, :height => height }
      ckeditor_options[:language] = (options.delete(:language) || I18n.locale).to_s
      ckeditor_options[:toolbar]  = options.delete(:toolbar) if options[:toolbar]
      ckeditor_options[:skin]     = options.delete(:skin) if options[:skin]
      
      ckeditor_options[:swf_params] = options.delete(:swf_params) if options[:swf_params]
      
      ckeditor_options[:filebrowserBrowseUrl] = Ckeditor.file_manager_uri
      ckeditor_options[:filebrowserUploadUrl] = Ckeditor.file_manager_upload_uri
      
      ckeditor_options[:filebrowserImageBrowseUrl] = Ckeditor.file_manager_image_uri
      ckeditor_options[:filebrowserImageUploadUrl] = Ckeditor.file_manager_image_upload_uri
      
      output_buffer = ActiveSupport::SafeBuffer.new
        
      output_buffer << ActionView::Base::InstanceTag.new(object, field, self, var).to_text_area_tag(textarea_options.merge(options))
      
      output_buffer << javascript_tag("if (CKEDITOR.instances['#{element_id}']) { 
        CKEDITOR.remove(CKEDITOR.instances['#{element_id}']);}
        CKEDITOR.replace('#{element_id}', { #{ckeditor_applay_options(ckeditor_options)} });")
        
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
      
      def ckeditor_element_id(object, field, index = nil)
        index.blank? ? "#{object}_#{field}_editor" : "#{object}_#{index}_#{field}_editor"
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
