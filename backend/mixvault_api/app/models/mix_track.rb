# frozen_string_literal: true

class MixTrack < ApplicationRecord
  belongs_to :mix
  belongs_to :track

  validates :position, numericality: { only_integer: true, greater_than: 0 }
  validates :start_seconds, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :end_seconds, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true


  validates :track_id, uniqueness: { scope: :mix_id, message: "is already in this mix" }
  validates :position, uniqueness: { scope: :mix_id, message: "is already taken in this mix" }

  validate :end_after_start
  validate :start_seconds_must_fit_position_order

  private

  def end_after_start
    return if end_seconds.nil?
    errors.add(:end_seconds, "must be > start_seconds") if end_seconds <= start_seconds
  end 

  def start_seconds_must_fit_position_order
    return unless mix && position && start_seconds

    previous = mix.mix_tracks
                  .where("position < ?", position)
                  .order(position: :desc)
                  .first

    if previous && start_seconds <= previous.start_seconds
      errors.add(:start_seconds, "must be > previous track start time (position #{previous.position})")
    end 

    nxt = mix.mix_tracks
              .where("position > ?", position)
              .order(position: :asc)
              .first
    if nxt 
      if start_seconds >= nxt.start_seconds
        errors.add(:start_seconds, "must be < next track start time (position #{nxt.position})")
      end
    else
      # no next track — keep it within the mix length (if known)
      if mix.respond_to?(:duration_seconds) && mix.duration_seconds.present? && start_seconds >= mix.duration_seconds
        errors.add(:start_seconds, "must be < mix duration (#{mix.duration_seconds}s)")
      end
    end
  end           
end
