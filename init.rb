Dir[File.join(File.dirname(__FILE__), 'vendor/*/lib')].each do |path|
  $LOAD_PATH.unshift path
end

require 'ckeditor'

# make plugin controller available to app
config.load_paths += %W(#{Ckeditor::PLUGIN_CONTROLLER_PATH} #{Ckeditor::PLUGIN_HELPER_PATH})

Rails::Initializer.run(:set_load_path, config)

# require the controller
require 'ckeditor_controller'
