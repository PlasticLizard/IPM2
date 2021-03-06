(function($){
    $.maestro = $.maestro || {
        dialogs:{
        }
    };

    $.maestro.dialogs.roleSelector = function(department_id,selected_roles,options)
    {
        options = options || {};
        var dlg_id = "maestro_dialogs_roleSelector_" + department_id;
        var dlg = $("#" + dlg_id);
        if (dlg.length==0)
        {
            dlg = $("<div id='" + dlg_id + "'></div>");
            dlg.load("/admin/departments/" + department_id + "/roles/select",function(){
                dlg.jstree({
                    plugins : [ "themes", "html_data", "ui"  ]
                });
                dlg.append("<div class='ui-widget-footer' style='float:right;padding-top:10px;padding-bottom:5px'> \
            <button class='ok'>Ok</button> \
            <button class='cancel'>Cancel</button> \
            </div>");
                showDialog(selected_roles,options,dlg);
            });
        }
        else
            showDialog(selected_roles,options,dlg);

        function showDialog(selected_roles,options,dlg)
        {
            var node_ids = $.map(selected_roles,function(item){return "#" + item});
            var tree = $.jstree._reference(dlg);
            tree.open_all();


            options.modal = options.modal || true;
            options.title = options.title || "Select a role";
            options.closeable = false;
            
            dlg.find("button").unbind().click(function(){
                Boxy.get(this).hide();
            });
            dlg.find("button.ok").click(function(){
                var checkedNodes = tree.get_selected();
                var selected =
                        extractSelected(checkedNodes);
                if (options.onSelection)
                    options.onSelection.apply(this,[selected]);

            });
            options.afterHide = function(){

            };

            b = new Boxy(dlg,options);
            b.moveTo(null,100);
            $(".title-bar").addClass("ui-widget-header");

            uncheckAll(tree);
            $.each(node_ids,function(index,node){tree.select_node(node)});
        }

        function uncheckAll(tree)
        {
            var checkedNodes = tree.get_selected();
            checkedNodes.each(function(index,node){tree.deselect_node(node)});
        }

        function extractSelected(checked_nodes)
        {
            var selected_names = [];
            var selected_ids = [];
            checked_nodes.each(function(index,node){
                var info = getNodeNameAndId(node);
                selected_names.push(info[0]);
                selected_ids.push(info[1]);
            });
            return [selected_names,selected_ids];
        }

        function getNodeNameAndId(node)
        {
            node = $(node);
            return [node.find("a").first().text(),node.attr("id")];
        }

    }

})(jQuery);