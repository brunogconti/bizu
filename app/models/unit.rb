class Unit < ApplicationRecord
  has_many :courses
  belongs_to :citie
  belongs_to :institution

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
