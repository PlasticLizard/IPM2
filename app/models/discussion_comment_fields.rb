module DiscussionCommentFields
  def self.included(model)

    model.timestamps!

    model.key :author_id, ObjectId, :required=>true
    model.belongs_to :user

    model.key :title, String, :required=>true
    model.key :comment, String, :required=>true

    model.many :replies, :class_name=>"DiscussionComment"
  end

end