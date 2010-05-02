# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def init_resource_edit_in_place
    javascript_tag("$.fn.editInPlace.defaults.url='#{resource.id}';$('.editable').editInPlace();")
  end
end
