# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :posts
  has_many :comments, class_name: 'PostComment'
  has_many :likes, dependent: :destroy, class_name: 'PostLike'

  validates :email, :password, presence: true
end
