module Types
  class PostType < VotableObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :title, String, null: false
    field :text, String, null: true
    field :tags, [TagType], null: true
    field :comments, [CommentType], null: true, resolver: Resolvers::PostRootCommentsResolver
    field :comments_count, Integer, null: false, resolver: Resolvers::CommentsCountResolver
  end
end
