class Track < ApplicationRecord
  belongs_to :label, optional: true

  has_many :mix_tracks, dependent: :destroy
  has_many :mixes, through: :mix_tracks
end