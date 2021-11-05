class Course < ApplicationRecord
  has_many :bookmarks
  has_many :reviews
  has_many :segments
  belongs_to :unit
end
