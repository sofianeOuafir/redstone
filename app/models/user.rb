class User < ApplicationRecord
  has_many :posts
  has_many :places, through: :posts
  has_many :countries, through: :posts
end
