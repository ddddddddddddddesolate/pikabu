# frozen_string_literal: true

# https://file-examples-com.github.io/uploads/2017/10/file_example_JPG_100kB.jpg

require 'faker'

# users generator
10.times do
  User.create(name: Faker::Name.unique.name, email: Faker::Internet.unique.email, password: '123456')
end

# posts generator
20.times do
  post = Post.create(
    user_id: User.all.sample.id,
    title: Faker::Lorem.sentence(word_count: 3),
    text: Faker::Lorem.sentence(word_count: 10),
    created_at: rand(1..50).hours.ago
  )

  rand(0..3).times do
    post.images.create(remote_image_url: 'https://file-examples-com.github.io/uploads/2017/10/file_example_JPG_100kB.jpg')
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

  rand(0..2).times do
    comment.images.create(remote_image_url: 'https://file-examples-com.github.io/uploads/2017/10/file_example_JPG_100kB.jpg')
  end
end

# likes / dislikes generator
200.times do
  Post.all.sample.reactions.create(
    reaction: rand(0..1),
    user_id: User.all.sample.id,
    created_at: rand(1..50).hours.ago
  )
  Comment.all.sample.reactions.create(
    reaction: rand(0..1),
    user_id: User.all.sample.id,
    created_at: rand(1..50).hours.ago
  )
end
