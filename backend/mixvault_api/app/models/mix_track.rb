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

  validate :start_time_must_be_after_previous_track

private

  def start_time_must_be_after_previous_track
    previous = mix.mix_tracks
                  .where("position < ?", position)
                  .order(position: :desc)
                  .first

    return unless previous && start_seconds < previous.start_seconds

    errors.add(:start_seconds, "must be after the previous track starts")
  end           
end
