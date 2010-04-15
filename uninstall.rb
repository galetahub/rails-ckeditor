require "lib/ckeditor/utils"
require "lib/ckeditor/version"

puts "** Uninstalling CKEditor Plugin version #{Ckeditor::Version.current}...."

Ckeditor::Utils.destroy
