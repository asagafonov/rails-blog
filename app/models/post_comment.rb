# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :post, counter_cache: :comments_count
  belongs_to :user

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
  validates :content, presence: true
end
