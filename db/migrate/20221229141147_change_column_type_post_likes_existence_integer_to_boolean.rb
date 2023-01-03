# frozen_string_literal: true

class ChangeColumnTypePostLikesExistenceIntegerToBoolean < ActiveRecord::Migration[7.0]
  def change
    change_column :post_likes, :existence, :boolean
  end
end
