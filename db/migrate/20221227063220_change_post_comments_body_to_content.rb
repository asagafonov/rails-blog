class ChangePostCommentsBodyToContent < ActiveRecord::Migration[7.0]
  def change
    rename_column :post_comments, :body, :content
  end
end
