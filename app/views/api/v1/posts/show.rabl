object @post
attributes :id, :title, :text, :likes_counter, :comments_counter
node(:post_owner) { |m| m.user.name }

count = @post.comments_counter
count.times do |c|
  comment_name = "comment_#{c + 1}"
  node(:"#{comment_name}") do |m|
    m.comments[c].text
  end
end
