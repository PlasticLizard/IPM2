module Admin::CompaniesHelper
  def org_tree_html
    arranged = Account.current.organizational_model
    "<div id='org_tree'>" + org_subtree_html(arranged) + "</div>"
  end

  private
  def org_subtree_html(tree_hash)
    output = "<ul>"
    tree_hash.keys.each do |node|
      output << "<li id='#{node.id}' class='jstree-open' rel='organizational-unit' data-collection-name='#{node.class.name.pluralize.underscore}'><a href='#'>#{node.name}</a>"
      output << org_subtree_html(tree_hash[node]) unless tree_hash[node].empty?
      output << "</li>"
    end
    output << "</ul>"
    output
  end
end
