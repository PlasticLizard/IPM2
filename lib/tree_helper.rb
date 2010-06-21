class TreeHelper
  class << self
    def arrange_tree_nodes(node_list,parent_id=nil,parent_hash=BSON::OrderedHash.new)

    children = node_list.select{|n|n.parent_id==parent_id}
    children.each{|c|parent_hash[c]=arrange_tree_nodes(node_list,c.id,BSON::OrderedHash.new)}
    parent_hash
  end
  end
end