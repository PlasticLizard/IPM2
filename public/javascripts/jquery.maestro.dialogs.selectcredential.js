(function($){
    $.maestro = $.maestro || {
        dialogs:{
        }
    };

    $.maestro.dialogs.selectCredential = function(department_id,options)
    {
        options = options || {};
        var dlg_id = "maestro_dialogs_credentialSelector";
        var dlg = $("#" + dlg_id);
        if (dlg.length==0)
        {
            dlg = $("<div id='" + dlg_id + "'></div>");
            dlg.load("/admin/credentials/select",function(){

                dlg.append("<div class='ui-widget-footer' style='float:right;padding-top:10px;padding-bottom:5px'> \
            <button class='ok dialog-button'>Ok</button> \
            <button class='cancel dialog-button'>Cancel</button> \
            </div>");
                var tree = dlg.credentialTree();

                //Only allow credentials to be selected
                tree.bind("before.jstree", function (e, data) {
                    if(data.func === "select_node") {
                        var node = data.args.length == 3 ? data.args[2].currentTarget : data.args[0];
                        var node_type = $.jstree._reference(tree)._get_node(node).attr("rel");
                        if (node_type != "credential")
                        {
                            e.stopImmediatePropagation();
                            return false;
                        }
                    }
                });

                showDialog(department_id,options,dlg);
            });
        }
        else
            showDialog(department_id,options,dlg);

        function showDialog(department_id,options,dlg)
        {

            options.modal = options.modal || true;
            options.title = options.title || "Select a role";
            options.closeable = false;

            dlg.find("li[rel=department]").hide();
            var dep = dlg.find("#" + department_id);
            dep.show();

            var tree = $.jstree._reference(dep);

            tree.open_node(dep);
            tree.deselect_all(dep);

            dlg.find("button.dialog-button").unbind();

            dlg.find("button.cancel").button().click(function(){
                Boxy.get(this).hide();
            });
            dlg.find("button.ok").button().click(function(){
                var selected = tree.get_selected();
                var selected_ids = $.map(selected,function(item){return item.id});
                var credential_id = selected.length > 0 ? selected[0].id : null;
                if (credential_id)
                {
                    if (options.onSelection)
                        options.onSelection.apply(this,[selected_ids]);
                    Boxy.get(this).hide();
                }
                else
                    alert("You must select a credential");;

            });
            options.afterHide = function(){

            };

            b = new Boxy(dlg,options);
            b.moveTo(null,100);
            $(".title-bar").addClass("ui-widget-header");
        }
    }

})(jQuery);