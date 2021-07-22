# https://file-examples-com.github.io/uploads/2017/10/file_example_JPG_100kB.jpg

require "faker"

# users generator
30.times do
  User.create(name: Faker::Name.unique.name, email: Faker::Internet.unique.email, password: "123456")
end

# posts generator
30.times do
  post = Post.create(user_id: User.all.sample.id, title: Faker::Lorem.sentence(word_count: 3), text: Faker::Lorem.sentence(word_count: 10))

  rand(1..3).times do
    post.images.create(remote_image_url: "https://file-examples-com.github.io/uploads/2017/10/file_example_JPG_100kB.jpg")
  end
end

# comments generator
40.times do
  comment = Comment.create(post_id: Post.all.sample.id, user_id: User.all.sample.id, text: Faker::Lorem.sentence(word_count: 5))

  rand(0..2).times do
    comment.images.create(remote_image_url: "https://file-examples-com.github.io/uploads/2017/10/file_example_JPG_100kB.jpg")
  end
end

# likes / dislikes generator
20.times do
  Post.all.sample.votes.create(reaction: rand(0..1), user_id: User.all.sample.id)
  Comment.all.sample.votes.create(reaction: rand(0..1), user_id: User.all.sample.id)
end
