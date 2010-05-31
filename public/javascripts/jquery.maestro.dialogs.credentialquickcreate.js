(function($){
    $.maestro = $.maestro || {
        dialogs:{
        }
    };

    $.maestro.dialogs.credentialQuickCreate = function(credentialType,options)
    {
        options = options || {};
        var dlg_id = "maestro_dialogs_credentialQuickCreate_" + credentialType;
        var dlg = $("#" + dlg_id);
        if (dlg.length==0)
        {
            dlg = $("<div id='" + dlg_id + "'></div>");
            dlg.load("credentials/quick_add?credential_type=" + credentialType,function(){

                dlg.append("<div class='ui-widget-footer' style='float:right;padding-top:10px;padding-bottom:5px'> \
            <button class='ok'>Ok</button> \
            <button class='cancel'>Cancel</button> \
            </div>");
                showDialog(dlg,credentialType,options);
            });
        }
        else
            showDialog(dlg,credentialType,options);

        function showDialog(dlg,credentialType,options)
        {
            dlg.find("form")[0].reset();
            dlg.find("button").unbind().click(function(){
                Boxy.get(this).hide();
            });
            dlg.find("button.ok").click(function(){
                dlg.find("form").ajaxSubmit(function(response){
                    if (options.onSubmit)
                        options.onSubmit.apply(this,[response]);
                });
            });

            options.modal = options.modal || true;
            options.title = options.title || "Create a new " + credentialType;
            options.closeable = false;

            b = new Boxy(dlg,options);
            b.moveTo(null,100);
            $(".title-bar").addClass("ui-widget-header");

        }

    }

})(jQuery);