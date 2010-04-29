module Admin::RolesHelper

  def role_tree_html
    arranged = @roles.arrange
    subtree_html(arranged)
  end

  private
  def subtree_html(tree_hash)
    output = "<ul>"
    tree_hash.keys.each do |node|
      output << "<li id='role_#{node.id}' class='open'><a href='#'><ins></ins>#{node.name}</a>"
      output << subtree_html(tree_hash[node]) unless tree_hash[node].empty?
      output << "</li>"
    end
    output << "</ul>"
    output
  end
end
