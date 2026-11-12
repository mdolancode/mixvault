# frozen_string_literal: true

module Mutations
  class AddTrackToMix < Mutations::BaseMutation
    argument :mix_id, ID, required: true
    argument :track_id, ID, required: true
    argument :position, Integer, required: true
    argument :start_seconds, Integer, required: true

    field :mix_track, Types::MixTrackType, null: true
    field :errors, [ String ], null: false

    def resolve(mix_id:, track_id:, position:, start_seconds:)
      mix = Mix.find_by(id: mix_id)
      return { mix_track: nil, errors: [ "Mix not found" ] } unless mix

      track = Track.find_by(id: track_id)
      return { mix_track: nil, errors: [ "Track not found" ] } unless track

      existing = MixTrack.find_by(mix_id: mix_id, track_id: track_id)
      return { mix_track: existing, errors: [ "Track is already in this mix" ] } if existing

      mix_track = MixTrack.new(
        mix: mix,
        track: track,
        position: position,
        start_seconds: start_seconds
      )

      if mix_track.save
        { mix_track: mix_track, errors: [] }
      else
        { mix_track: nil, errors: mix_track.errors.full_messages }
      end
    end
  end
end
