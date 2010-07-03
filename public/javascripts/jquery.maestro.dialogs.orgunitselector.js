(function($){
    $.maestro = $.maestro || {
        dialogs:{
        }
    };

    $.maestro.dialogs.organizationalUnitSelector = function(selected,options)
    {
        options = options || {};
        var dlg_id = "maestro_dialogs_orgUnitSelector";
        var dlg = $("#" + dlg_id);
        if (dlg.length==0)
        {
            dlg = $("<div id='" + dlg_id + "'></div>");
            dlg.load("organizational_units/select",function(){
                dlg.jstree({
                    plugins : [ "themes", "html_data", "ui", "checkbox"  ]
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


            options.modal = options.modal || true;
            options.title = options.title || "Select a geography";
            options.closeable = false;
            
            dlg.find("button").unbind().click(function(){
                Boxy.get(this).hide();
            });
            dlg.find("button.ok").click(function(){
                var selected =
                        extractSelectedOrgUnits(tree,tree.get_checked(),null);
                if (options.onSelection)
                    options.onSelection.apply(this,[selected]);

            });
            options.afterHide = function(){

            };

            b = new Boxy(dlg,options);
            b.moveTo(null,100);
            $(".title-bar").addClass("ui-widget-header");

            uncheckAll(tree);
            $.each(node_ids,function(index,node){tree.check_node(node)});
        }

        function uncheckAll(tree)
        {
            var checkedNodes = tree.get_checked();
            checkedNodes.each(function(index,node){tree.uncheck_node(node)});
        }

        function extractSelectedOrgUnits(tree,nodes,selections)
        {
            if (selections == null)  selections = [[],[]];
            nodes.each(function(index,node){
                var info = getNodeNameAndId(node);
                selections[0].push(info[0]);
                selections[1].push(info[1]);
                var children = tree._get_children(node);
                if (children && children.length > 0){
                    extractSelectedOrgUnits(tree,children,selections);
                }
            });

            return selections;
        }

        function getNodeNameAndId(node)
        {
            node = $(node);
            return [node.find("a").first().text(),node.attr("id")];
        }

    }

})(jQuery);