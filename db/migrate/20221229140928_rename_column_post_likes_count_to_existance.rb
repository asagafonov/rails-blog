# frozen_string_literal: true

class RenameColumnPostLikesCountToExistance < ActiveRecord::Migration[7.0]
  def change
    rename_column :post_likes, :count, :existence
  end
end
