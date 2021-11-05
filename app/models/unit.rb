class Unit < ApplicationRecord
  has_many :courses
  belongs_to :citie
  belongs_to :institution
end
