(function($){
    $.maestro = $.maestro || {
        dialogs:{
        }
    };

    $.maestro.dialogs.issueCredential = function(employee_id,options)
    {
        options = options || {};
        var dlg_id = "maestro_dialogs_issueCredential";
        var dlg = $("#" + dlg_id);
        if (dlg.length==0)
        {
            dlg = $("<div id='" + dlg_id + "'></div>");
            dlg.load(employee_id + "/issued_credentials/select",function(){

                dlg.append("<div class='ui-widget-footer' style='float:right;padding-top:10px;padding-bottom:5px'> \
            <button class='ok'>Ok</button> \
            <button class='cancel'>Cancel</button> \
            </div>");
                showDialog(dlg,employee_id,options);
            });
        }
        else
            showDialog(dlg,employee_id,options);

        function showDialog(dlg,employee_id,options)
        {
            dlg.find("form")[0].reset();
            dlg.find(".date-field").datepicker();
            dlg.find("#issue_date").datepicker("setDate",new Date());
            dlg.find("button").unbind().click(function(){
                Boxy.get(this).hide();
            });
            dlg.find("button.ok").click(function(){
                var sel = dlg.find("select");

                cred_id = sel.val();
                cred_name = dlg.find('option:selected').text();

                cred_issue_date = dlg.find("#issue_date").val();
                cred_expiration_date = dlg.find("#expiration_date").val();

                $.ajax({
                    type:'POST',
                    url:employee_id + "/issued_credentials/issue",
                    data:{_method:'put',
                        credential_id:cred_id,
                        issue_date:cred_issue_date,
                        expiration_date:cred_expiration_date
                    },
                    success:function(data){
                        if (options.onSubmit)
                            options.onSubmit.apply(this,[{id:cred_id,
                                name:cred_name,
                                issue_date:cred_issue_date,
                                expiration_date:cred_expiration_date}]);
                    }
                });


            });

            options.modal = options.modal || true;
            options.title = options.title || "Issue a credential";
            options.closeable = false;

            b = new Boxy(dlg,options);
            b.moveTo(null,100);
            $(".title-bar").addClass("ui-widget-header");

        }

    }

})(jQuery);