class Post < ApplicationRecord
  belongs_to :place, optional: true
  belongs_to :user
  has_one :country, through: :place
end
