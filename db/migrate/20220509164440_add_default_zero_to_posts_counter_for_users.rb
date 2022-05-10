class AddDefaultZeroToPostsCounterForUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :posts_counter, 0
  end
end
