class Citie < ApplicationRecord
  has_many :units
  has_many :courses, through: :units
end
