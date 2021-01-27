class BlogSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :body,
    :created_at,
    :updated_at
  )

  belongs_to :user, key: :admin 
  has_many :comments 

  class CommentSerializer < ActiveModel::Serializer 
    attributes(
      :id,
      :body,
      :created_at
    )
  end
end
