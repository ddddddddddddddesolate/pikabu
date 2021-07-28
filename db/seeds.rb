# frozen_string_literal: true

require 'faker'

image = File.open(Rails.root.join('data', 'sample.jpeg'))

# users generator
10.times do
  User.create(name: Faker::Name.unique.name, email: Faker::Internet.unique.email, password: '123456')
end

# posts generator
50.times do
  post = Post.create(
    user_id: User.all.sample.id,
    title: Faker::Lorem.sentence(word_count: 3),
    text: Faker::Lorem.sentence(word_count: 10),
    created_at: rand(1..50).hours.ago
  )

  # post images
  rand(0..3).times do
    post.images.create(image: image)
  end
end

# comments generator
150.times do
  comment = Comment.create(
    post_id: Post.all.sample.id,
    user_id: User.all.sample.id,
    text: Faker::Lorem.sentence(word_count: 5),
    created_at: rand(1..50).hours.ago
  )

  # comment images
  rand(0..2).times do
    comment.images.create(image: image)
  end

  # replies
  rand(0..10).times do
    reply = comment.comments.create(
      post_id: Post.all.sample.id,
      user_id: User.all.sample.id,
      text: Faker::Lorem.sentence(word_count: 5),
      created_at: rand(1..50).hours.ago
    )

    # reply images
    rand(0..2).times do
      reply.images.create(image: image)
    end
  end
end

# likes / dislikes for posts
300.times do
  Post.all.sample.reactions.create(
    reaction: rand(0..1),
    user_id: User.all.sample.id,
    created_at: rand(1..50).hours.ago
  )
end

# likes / dislikes for comments
1500.times do
  Comment.all.sample.reactions.create(
    reaction: rand(0..1),
    user_id: User.all.sample.id,
    created_at: rand(1..50).hours.ago
  )
end

# bookmarks
User.all.each do |user|
  rand(0..15).times do
    types = [Post, Comment]

    user.bookmarks.find_or_create_by(bookmarkable: types.sample.all.sample)
  end
end

# tags
Post.all.each do |post|
  rand(3..5).times do
    post.tags.find_or_create_by(name: Faker::Lorem.sentence(word_count: 2))
  end
end
