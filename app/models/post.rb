class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  scope :by_creation_date_desc, -> { where(order: :desc) }
end
