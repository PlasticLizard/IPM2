class Admin::RequirementSetsController  < InheritedResources::Base
  include AccountResourceController
   belongs_to :department, :optional=>true
   
   def index
#    if (request.xhr?)
#      list
#    else
      @requirements = current_account.requirement_sets.by_department
      @show_title = true
      render :layout=>'left_sidebar'
#    end
  end

  def list
    render :partial=>"requirement_set_list", :locals=>{:requirement_sets=>collection, :department=>parent}
   end

   def show
    show! do |format|
      format.all { render :partial=>"show"}
    end
  end

  def create
    create! do |format|
      format.json { render :json=>resource.to_json }
    end
  end

  def destroy
    destroy! do |format|
      format.json {render :nothing => true}
    end
  end

  def update
    update! do |format|
      format.json {render :json=>{:ok=>true}.to_json}
    end
  end
end
