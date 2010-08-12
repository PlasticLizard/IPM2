(function($){

    $.fn.credentialTree = function(options) {
        options = options || {};
        var selected = options.selected;
        selected = selected ? [selected] : [];

        var tree = this.find("#credential_tree").jstree({
            ui : {initially_select:selected},
            core : {animation:50},
            plugins : [ "themes", "html_data", "ui", "crrm" ]
        })
                .bind("select_node.jstree",function(event,data){

            var department_id = data.rslt.obj.attr("data-department-id");
            var type_name = data.rslt.obj.attr("data-credential-type");
            var credential_id = data.rslt.obj.attr("data-credential-id");

            if (data.rslt.obj.attr("rel") == "department"){
                $(document).trigger("department.selected",[department_id]);
            }
            else if (data.rslt.obj.attr("rel") == "credential_type"){
                $(document).trigger("credential_type.selected",[department_id,type_name]);
            }
            else if (data.rslt.obj.attr("rel") == "credential"){
                $(document).trigger("credential.selected",[department_id,credential_id]);
            }

        });

        this.find("#create_credential").button().click(function(){
            $.maestro.dialogs.createCredential({
                onSubmit:function(credential){
                    var tree = $.jstree._reference("#credential_tree");
                    var folder = $("#" + credential["department_id"] + "_" + credential["type_name"]);
                    if (folder.length == 0){
                        var dep_node = tree.find("#" + credential["department_id"]);
                        tree.create_node(dep_node,"last",{
                            attr:{
                                id:credential["department_id"] + "_" + credential["type_name"],
                                "data-department-id":credential["department_id"],
                                "data-credential-type":credential["type_name"],
                                rel:"credential_type"
                            },
                            data:credential["type_name"]
                        });
                        folder = $("#" + credential["department_id"] + "_" + credential["type_name"]);
                    }
                    else { folder = tree._get_node(folder)}

                    tree.create_node(folder,"last",{
                        attr:{
                            id: credential["id"],
                            "data-department-id":credential["department_id"],
                            "data-credential-type":credential["type_name"],
                            "data-credential-id":credential["id"],
                            rel:"credential"
                        },
                        data:{
                            attr:{title:credential["name"]},
                            title:credential["name"]
                        }
                    });
                    $(document).trigger("credential.selected",[credential["department_id"],credential["id"]]);
                    //                        tree.select_node("#" + credential["id"]);
                }
            });
        });

        $(document).bind("department.selected",function(e,department_id){
            select_node("#credential_tree","#" + department_id);
        });

        $(document).bind("credential_type.selected",function(e,department_id,credential_type){
            select_node("#credential_tree","#" + department_id + "_" + credential_type);
        });

        $(document).bind("credential.deleted",function(e,credential_id){
            $.jstree._reference("#credential_tree").remove("#" + credential_id);
        });

        $(document).bind("credential.renamed",function(e,credential_id,new_name){
            var tree = $.jstree._reference("#credential_tree");
            if (tree.get_text("#" + credential_id) != new_name)
                tree.set_text("#" + credential_id,new_name);
        });

        $(document).bind("credential.selected",function(e,department_id,credential_id){
            select_node("#credential_tree","#" + credential_id);
        });

        return tree;
        
    };


})(jQuery);