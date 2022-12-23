class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :comments, dependent: :destroy, class_name: 'PostComment', foreign_key: :post_id

  scope :by_creation_date_desc, -> { order(created_at: :desc) }
  validates :title, :body, presence: true
end
