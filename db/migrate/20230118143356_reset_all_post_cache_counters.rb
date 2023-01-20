# frozen_string_literal: true

class ResetAllPostCacheCounters < ActiveRecord::Migration[7.0]
  def up
    Post.all.each do |post|
      Post.reset_counters(post.id, :comments)
      Post.reset_counters(post.id, :likes)
    end
  end
end
