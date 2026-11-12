class Mix < ApplicationRecord
  enum :status, { draft: 0, verified: 1, published: 2, rejected: 3 }, default: :draft

  has_many :mix_tracks, dependent: :destroy
  has_many :tracks, through: :mix_tracks
end
