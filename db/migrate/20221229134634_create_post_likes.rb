# frozen_string_literal: true

class CreatePostLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :post_likes do |t|
      t.integer :count
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
