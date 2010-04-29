require 'spec_helper'

describe Admin::RolesHelper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(Admin::RolesHelper)
  end

  it "should prepare an un-ordered list from the hash of tree nodes provided" do
    tree_hash = {OrganizationalRole.new(:id=>1, :name=>"o1")=>{OrganizationalRole.new(:id=>2,:name=>"o2")=>{},
                                                               OrganizationalRole.new(:id=>3,:name=>"o3")=>{}}}

    expected = "<ul><li id='role_1' class='open'><a href='#'><ins></ins>o1</a><ul><li id='role_2' class='open'><a href='#'><ins></ins>o2</a></li><li id='role_3' class='open'><a href='#'><ins></ins>o3</a></li></ul></li></ul>"

    helper.send(:subtree_html,tree_hash).should == expected
  end

end
