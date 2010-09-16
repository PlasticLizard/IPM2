require 'spec_helper'

describe Discussion do
  before(:each) do
    @group_attributes = {:name=>"My Group"}
    @topic_attributes = {:name=>"My Topic"}
    @topic = DiscussionGroup.create(@group_attributes).topics.build(@topic_attributes)
    @valid_attributes = {:discussion_topic_id=>@topic.id,
                         :author_id=>BSON::ObjectId.new,
                         :title=>"discussion title",
                         :comment=>"discussion body"}

  end

  it "should create a new instance given valid attributes" do
    Discussion.create!(@valid_attributes)
  end

  it "should be invalid without a topic, author, title and comment" do
    comment = Discussion.create
    comment.should_not be_valid
    comment.errors.on(:discussion_topic_id).should_not be_empty
    comment.errors.on(:author_id).should_not be_empty
    comment.errors.on(:title).should_not be_empty
    comment.errors.on(:comment).should_not be_empty
    comment.discussion_topic_id = @topic.id
    comment.author_id = BSON::ObjectId.new
    comment.title = "t"
    comment.comment = "c"
    comment.should be_valid
  end

  it "should store nested replies one level deep" do
    comment = Discussion.create!(@valid_attributes)
    comment.replies.build(@valid_attributes.except(:discussion_topic_id))
    comment.replies.build(@valid_attributes.except(:discussion_topic_id))
    comment.save!
    comment.reload

    comment.replies.count.should be 2
  end

  it "should store a tree of nested replies" do
    comment = Discussion.create!(@valid_attributes)
    r1 = comment.replies.build(@valid_attributes.except(:discussion_topic_id))
    r2 = r1.replies.build(@valid_attributes.except(:discussion_topic_id))
    r2.replies.build(@valid_attributes.except(:discussion_topic_id))
    r2.replies.build(@valid_attributes.except(:discussion_topic_id))
    comment.replies.build(@valid_attributes.except(:discussion_topic_id))
    comment.save!
    comment.reload

    comment.replies.count.should be 2
    comment.replies[0].replies.count.should be 1
    comment.replies[0].replies[0].replies.count.should be 2
  end

end
