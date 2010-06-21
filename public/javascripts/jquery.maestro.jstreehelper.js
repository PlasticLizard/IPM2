function select_node(node){
    var tree = $.jstree._reference("#credential_tree");
    node = tree._get_node(node);

    if (tree.is_selected(node)) return;

    tree.select_node(node, true);

    var parent = node;
    while (parent = tree._get_parent(parent)){
        tree.open_node(parent);
    }
}
