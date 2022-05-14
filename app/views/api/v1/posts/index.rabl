collection @posts
attributes :id, :title, :text, :comments_counter, :likes_counter
child(:user) { attributes :id, :name, :bio }