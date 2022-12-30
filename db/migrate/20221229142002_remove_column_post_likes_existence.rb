class RemoveColumnPostLikesExistence < ActiveRecord::Migration[7.0]
  def change
    remove_column :post_likes, :existence
  end
end
