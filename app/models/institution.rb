class Institution < ApplicationRecord
  has_many :units
  has_manu :courses, through: :units
end
