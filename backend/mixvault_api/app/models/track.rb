class Track < ApplicationRecord
  belongs_to :label

  has_many :mix_tracks, dependent: :destroy
  has_many :mixes, through: :mix_tracks

  validates :title, :artist, :bpm, presence: true
end
