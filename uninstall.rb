directory = File.join(RAILS_ROOT, '/vendor/plugins/easy-ckeditor/')

require "#{directory}lib/ckeditor/utils"
require "#{directory}lib/ckeditor/version"

puts "** Uninstalling Easy CKEditor Plugin version #{Ckeditor::Version.current}...."

Ckeditor::Utils.destroy
