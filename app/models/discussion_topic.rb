class DiscussionTopic
  include MongoMapper::EmbeddedDocument

  key :name, String, :required=>true
  #Code here

  many :discussions, :class_name=>"DiscussionComment"
end