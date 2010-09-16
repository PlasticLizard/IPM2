class DiscussionGroup < AccountModel

  key :name, String, :required=>true

  many :topics, :class_name=>"DiscussionTopic"

end