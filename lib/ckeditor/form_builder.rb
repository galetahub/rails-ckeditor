module Ckeditor
  module FormBuilder
    def self.included(base)
      base.send(:include, Ckeditor::ViewHelper)
      base.send(:include, Ckeditor::FormBuilder::ClassMethods)
    end
    
    module ClassMethods
      # Example:
		  # <% form_for :post, :url => posts_path do |form| %>
		  #   ...
		  #   <%= form.cktext_area :notes, :toolbar=>'Full', :width=>'400px', :heigth=>'200px' %>
		  # <% end %>
		  #
		  # With swfupload options:
		  # <%= form.cktext_area :content, :swf_params=>{:assetable_type=>'User', :assetable_id=>current_user.id} %>
		  def cktext_area(method, options = {})
      	ckeditor_textarea(@object_name, method, objectify_options(options))
      end
    end
  end
end
