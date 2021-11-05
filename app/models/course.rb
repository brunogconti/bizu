class Course < ApplicationRecord
  has_many :bookmarks
  has_many :reviews
  has_many :segments
  belongs_to :unit
  has_one :citie, through: :unit
  has_one :institution, through: :unit
end
