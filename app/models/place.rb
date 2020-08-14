class Place < ApplicationRecord
  has_many :posts
  has_many :users
  belongs_to :country
end
