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
  validate :end_seconds_must_fit_next_track_or_mix_duration

  private

  def end_after_start
    return if end_seconds.nil? || start_seconds.nil?

    errors.add(:end_seconds, "must be > start_seconds") if end_seconds <= start_seconds
  end

  def previous_mix_track
    mix.mix_tracks.where("position < ?", position).order(position: :desc).first
  end

  def next_mix_track
    mix.mix_tracks.where("position > ?", position).order(position: :asc).first
  end

  def start_seconds_must_fit_position_order
    return unless mix && position && start_seconds

    previous = previous_mix_track
    if previous && start_seconds <= previous.start_seconds
      errors.add(:start_seconds, "must be > previous track start time (position #{previous.position})")
    end

    nxt = next_mix_track
    if nxt
      if start_seconds >= nxt.start_seconds
        errors.add(:start_seconds, "must be < next track start time (position #{nxt.position})")
      end
    elsif mix.duration_seconds.present? && start_seconds >= mix.duration_seconds
      # last track: keep it within the mix length (if known)
      errors.add(:start_seconds, "must be < mix duration (#{mix.duration_seconds}s)")
    end
  end

  def end_seconds_must_fit_next_track_or_mix_duration
    return unless mix && position && end_seconds

    nxt = next_mix_track
    if nxt
      if end_seconds > nxt.start_seconds
        errors.add(:end_seconds, "must be <= next track start time (#{nxt.start_seconds}s, position #{nxt.position})")
      end
    elsif mix.duration_seconds.present? && end_seconds > mix.duration_seconds
      # last track: cannot run past the end of the mix (if known)
      errors.add(:end_seconds, "must be <= mix duration (#{mix.duration_seconds}s)")
    end
  end
end
