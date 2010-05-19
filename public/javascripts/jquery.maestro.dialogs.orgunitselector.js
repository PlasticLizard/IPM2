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
                dlg.tree({
                    plugins : {
                        checkbox : { three_state : true }
                    },
                    callback:{
                    },
                    ui:{
                        theme_name:"checkbox"
                    }

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
            var node_ids = $.map(selected,function(item){return "#ou_" + item});
            var tree = $.tree.reference(dlg);


            options.modal = options.modal || true;
            options.title = options.title || "Select a geography";
            options.closeable = false;
            
            dlg.find("button").unbind().click(function(){
                Boxy.get(this).hide();
            });
            dlg.find("button.ok").click(function(){
                var checkedNodes = $.tree.plugins.checkbox.get_checked(tree);
                var selected =
                        extractSelectedOrgUnits(checkedNodes);
                if (options.onSelection)
                    options.onSelection.apply(this,[selected]);

            });
            options.afterHide = function(){

            };

            b = new Boxy(dlg,options);
            b.moveTo(null,100);
            $(".title-bar").addClass("ui-widget-header");

            uncheckAll(tree);
            var nodes = $(node_ids.join(", "));
            nodes.each(function(index,node){$.tree.plugins.checkbox.check(node)});
        }

        function uncheckAll(tree)
        {
            var checkedNodes = $.tree.plugins.checkbox.get_checked(tree);
            checkedNodes.each(function(index,node){$.tree.plugins.checkbox.uncheck(node)});
        }

        function extractSelectedOrgUnits(checked_nodes)
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
            return [node.find("a").first().text(),node.attr("id").split("_").pop()];
        }

    }

})(jQuery);