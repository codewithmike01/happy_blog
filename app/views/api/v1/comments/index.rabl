collection @comments

attributes :id, :text, :user_id, :post_id

node(:user_name) { |c| c.user.name }
node(:post_title) { |c| c.post.title }