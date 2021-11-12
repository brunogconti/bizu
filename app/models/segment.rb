class Segment < ApplicationRecord
  belongs_to :course
  has_many :passing_scores
end
