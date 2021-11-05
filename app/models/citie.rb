class Citie < ApplicationRecord
  has_many :units
  has_manu :courses, through: :units
end
