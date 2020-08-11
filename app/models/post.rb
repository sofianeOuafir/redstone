class Post < ApplicationRecord
  belongs_to :place, optional: true
end
