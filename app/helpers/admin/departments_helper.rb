module Admin::DepartmentsHelper
   def subtree_html(tree_hash,department_id)
    output = "<ul>"
    tree_hash.keys.each do |node|
      output << "<li id='#{node.id}' data-organizational-role-id='#{node.id}' data-department-id='#{department_id}' class='jstree-open tooltip' rel='organizational-role'><a href='#' title='#{node.name}'>#{truncate(node.name,:length=>35)}</a>"
      output << subtree_html(tree_hash[node],department_id) unless tree_hash[node].empty?
      output << "</li>"
    end
    output << "</ul>"
    output
  end
end
