# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def org_tree_html
    arranged = Account.current.organizational_model
    org_subtree_html(arranged)
  end

  private
  def org_subtree_html(tree_hash)
    output = "<ul>"
    tree_hash.keys.each do |node|
      output << "<li id='ou_#{node.id}' class='open' rel='#{node.class.name.underscore}:#{node.class.name.pluralize.underscore}'><a href='#'><ins></ins>#{node.name}</a>"
      output << org_subtree_html(tree_hash[node]) unless tree_hash[node].empty?
      output << "</li>"
    end
    output << "</ul>"
    output
  end
end
