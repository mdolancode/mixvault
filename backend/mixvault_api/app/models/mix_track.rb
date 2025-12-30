class MixTrack < ApplicationRecord
  belongs_to :mix
  belongs_to :track

  validates :position, presence: true
  validates :start_seconds, presence: true
end
