class Label < ApplicationRecord
  has_many :tracks, dependent: :destroy
end
