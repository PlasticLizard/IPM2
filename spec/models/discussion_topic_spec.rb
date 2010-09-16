require 'spec_helper'

describe DiscussionTopic do
  before(:each) do
    @group_attributes = {:name=>"My Group"}
    @valid_attributes = {
            :name=>"My Topic"
    }
  end

  it "should create a new instance given valid attributes" do
    DiscussionGroup.create(@group_attributes).topics.build(@valid_attributes).save!
  end

  it "should be invalid without a name" do
    group = DiscussionGroup.create(@group_attributes)
    topic = group.topics.build(@valid_attributes.except(:name))
    topic.should_not be_valid
    topic.errors.on(:name).should_not be_empty
    topic.name = "Ta da"
    topic.should be_valid
  end

end
