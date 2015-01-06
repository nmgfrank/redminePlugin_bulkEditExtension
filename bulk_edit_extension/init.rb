require 'redmine'
require_dependency 'bulk_edit_extension/bulk_edit_extension_hook_listener'



Redmine::Plugin.register :bulk_edit_extension do
  name 'Bulk Edit Extension plugin'
  author 'nmgfrank'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://nmgfrankblog.sinaapp.com/'
end
