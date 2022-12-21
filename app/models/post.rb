class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
  validates :title, :body, presence: true
end
