(function($){
    $.maestro = $.maestro || {
        dialogs:{
        }
    };

    $.maestro.dialogs.createRequirementSet = function(options)
    {
        options = options || {};

        var dlg_id = "maestro_dialogs_createRequirementSet";
        var dlg = $("#" + dlg_id);
        if (dlg.length == 0){
            dlg = $("<div id='" + dlg_id + "'></div>");
            dlg.load("/admin/requirement_sets/new",function(){

                dlg.append("<div class='ui-widget-footer' style='float:right;padding-top:10px;padding-bottom:5px'> \
            <button class='ok'>Ok</button> \
            <button class='cancel'>Cancel</button> \
            </div>");
                showDialog(dlg,options);
            });
        }
        else
            showDialog(dlg,options);


        function showDialog(dlg,options)
        {
            dlg.find("form")[0].reset();
            dlg.find("button").unbind().click(function(){
                Boxy.get(this).hide();
            });
            dlg.find("button.ok").click(function(){
                dlg.find("form").ajaxSubmit({
                    success:function(result){
                        if (options.onSubmit){
                            options.onSubmit.apply(this,[result]);
                        }
                    }
                });

            });

            options.modal = options.modal || true;
            options.title = options.title || "Create a new requirement set";
            options.closeable = false;

            b = new Boxy(dlg,options);
            b.moveTo(null,100);
            $(".title-bar").addClass("ui-widget-header");

        }

    }

})(jQuery);