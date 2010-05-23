class Admin::RequirementGroupsController < InheritedResources::Base
  include AccountResourceController
  
  belongs_to :requirement_set, :optional=>true

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
