module Ckeditor
  module Hooks
    class FormtasticBuilder < ::Formtastic::SemanticFormBuilder

      private

      def ckeditor_input(attribute_name, options = {})
        html_options = options.delete(:input_html) || {}
        self.label(attribute_name, options_for_label(options)) <<
        self.send(:ckeditor_textarea, sanitized_object_name, attribute_name, html_options)
      end
    end
  end
end
