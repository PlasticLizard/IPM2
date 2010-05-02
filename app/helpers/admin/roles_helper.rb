module Admin::RolesHelper

  def position_type_description
    @role.enums(:position_type).label(@role.position_type)
  end

  def position_type_select_options
    @role.enums(:position_type).select_options.map{|opt|opt.join(":")}.join(",")
  end

  def organizational_unit_type_options
    Account.current.organizational_structure.map{|ou|"#{ou.to_s.humanize.downcase}:#{ou}"}.join(",")
  end
  
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
