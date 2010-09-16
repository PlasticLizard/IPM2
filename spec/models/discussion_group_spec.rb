require 'spec_helper'

describe DiscussionGroup do
  before(:each) do
    @valid_attributes = {
            :name=>"My Group"
    }
  end

  it "should create a new instance given valid attributes" do
    DiscussionGroup.create!(@valid_attributes)
  end

  it "should be invalid without a name" do
    group = DiscussionGroup.create(@valid_attributes.except(:name))
    group.should_not be_valid
    group.errors.on(:name).should_not be_empty
    group.name = "Ta da"
    group.should be_valid
  end

end
