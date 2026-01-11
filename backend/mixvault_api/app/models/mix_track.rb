# frozen_string_literal: true

class MixTrack < ApplicationRecord
  belongs_to :mix
  belongs_to :track

  validates :position, numericality: { only_integer: true, greater_than: 0 }
  validates :start_seconds, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :end_seconds, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  validate :end_after_start

  def end_after_start
    return if end_seconds.nil?
    errors.add(:end_seconds, "must be > start_seconds") if end_seconds <= start_seconds
  end 
end
