class Discussion < AccountModel

  key :discussion_topic_id, ObjectId, :required=>true
  belongs_to :discussion_topic

  include DiscussionCommentFields

  #Code here
end