(function($){
    $.maestro = $.maestro || {
        dialogs:{
        }
    };

    $.maestro.dialogs.organizationalUnitSelector = function(selected,options)
    {
        options = options || {};
        var singleSel = options.singleSelect || false;
        var plugins = [ "themes", "html_data", "ui"];
        if (!singleSel) plugins.push("checkbox");

        var dlg_id = "maestro_dialogs_orgUnitSelector";
        var dlg = $("#" + dlg_id);
        if (dlg.length==0)
        {
            dlg = $("<div id='" + dlg_id + "'></div>");
            dlg.load("/admin/organizational_units/select",function(){
                dlg.jstree({
                    plugins : plugins
                });

                dlg.append("<div class='ui-widget-footer' style='float:right;padding-top:10px;padding-bottom:5px'> \
            <button class='ok'>Ok</button> \
            <button class='cancel'>Cancel</button> \
            </div>");
                showDialog(selected,options,dlg);
            });
        }
        else
            showDialog(selected,options,dlg);

        function showDialog(selected,options,dlg)
        {
            var node_ids = $.map(selected,function(item){return "#" + item});
            var tree = $.jstree._reference(dlg);
            var singleSel = options.singleSelect || false;
            var returnAncestors = options.returnAncestors;
            var returnChildren = options.returnChildren;


            options.modal = options.modal || true;
            options.title = options.title || "Select a geography";
            options.closeable = false;

            dlg.find("button").unbind().click(function(){
                Boxy.get(this).hide();
            });
            dlg.find("button.ok").click(function(){
                var selected =
                        extractSelectedOrgUnits(tree,tree.get_selected(),null, returnAncestors,returnChildren);
                if (options.onSelection)
                    options.onSelection.apply(this,[selected]);

            });
            options.afterHide = function(){

            };

            b = new Boxy(dlg,options);
            b.moveTo(null,100);
            $(".title-bar").addClass("ui-widget-header");


            if (singleSel){
                deselectAll(tree);
                $.each(node_ids,function(index,node){tree.select_node(node)});
            }
            else {
                uncheckAll(tree);
                $.each(node_ids,function(index,node){tree.check_node(node)});
            }
        }

        function uncheckAll(tree)
        {
            var checkedNodes = tree.get_selected();
            checkedNodes.each(function(index,node){tree.uncheck_node(node)});
        }

        function deselectAll(tree)
        {
            var checkedNodes = tree.get_selected();
            checkedNodes.each(function(index,node){tree.deselect_node(node)});
        }

        function extractSelectedOrgUnits(tree,nodes,selections,returnAncestors,returnChildren)
        {
            if (selections == null)  selections = [];
            nodes.each(function(index,node){
                selections.push(getNodeData(node));
                
                if (returnAncestors)
                {
                    var parent = tree._get_parent(node);
                    extractAncestors(tree,parent,selections);
                }
                else if (returnChildren)
                {
                    var children = tree._get_children(node);
                    if (children && children.length > 0){
                        extractSelectedOrgUnits(tree,children,selections,returnAncestors);
                    }
                }

            });

            return selections;
        }

        function extractAncestors(tree,curNode,selections){
            if (curNode){
                selections.push(getNodeData(curNode));
                var parent = tree._get_parent(curNode);
                if (parent)
                    extractAncestors(tree,parent,selections);
            }
            return selections;
        }

        function getNodeData(node)
        {
            node = $(node);
            return {
                name: node.find("a").first().text(),
                id: node.attr("id"),
                type:node.attr("data-type")
            };
        }

    }

})(jQuery);