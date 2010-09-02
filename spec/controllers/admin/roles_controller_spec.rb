require 'spec_helper'

describe Admin::RolesController do

  #Delete this example and add some real ones
  it "should use Admin::RolesController.rb" do
    controller.should be_an_instance_of(Admin::RolesController)
  end

  it "should fetch the requested parent and add it to the params" do
    ou = OrganizationalRole.new :id=>BSON::ObjectId.new, :name=>"ou"
    OrganizationalRole.should_receive(:find).with(1).and_return(ou)
    params = {"role"=>{}}
    params = controller.send(:get_parented_attributes,1,params)
    params[:parent].should equal ou
  end

  it "should insert the department_id if present in the params" do
    OrganizationalRole.stub(:find).and_return({})
    params = {"role"=>{"department_id"=>"5"}}
    params = controller.send(:get_parented_attributes,1,params)
    params[:department_id].should == "5"
  end

end
