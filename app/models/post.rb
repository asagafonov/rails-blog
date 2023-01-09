# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :comments, dependent: :destroy, class_name: 'PostComment'
  has_many :likes, dependent: :destroy, class_name: 'PostLike'

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
  validates :title, :body, presence: true
end
