class DiscussionComment
  include MongoMapper::EmbeddedDocument
  plugin MongoMapper::Plugins::Timestamps

  include DiscussionCommentFields
end