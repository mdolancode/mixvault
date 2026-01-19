# frozen_string_literal: true

module Mutations
  class UpdateTrackInMix < Mutations::BaseMutation
    argument :mix_id, ID, required: true
    argument :track_id, ID, required: true
    argument :position, Integer, required: false
    argument :start_seconds, Integer, required: false
    argument :end_seconds, Integer, required: false

    field :mix_track, Types::MixTrackType, null: true
    field :errors, [String], null: false

    def resolve(mix_id:, track_id:, position: nil, start_seconds: nil, end_seconds: nil)
      mix = Mix.find_by(id: mix_id)
      return { mix_track: nil, errors: ["Mix not found"] } unless mix

      track = Track.find_by(id: track_id)
      return { mix_track: nil, errors: ["Track not found"] } unless track

      mix_track = MixTrack.find_by(mix_id: mix.id, track_id: track.id)
      return { mix_track: nil, errors: ["Track is not in this mix"] } unless mix_track

      attrs = {}
      attrs[:position] = position unless position.nil?
      attrs[:start_seconds] = start_seconds unless start_seconds.nil?
      # allow explicitly clearing end_seconds by passing null from GraphQL
      attrs[:end_seconds] = end_seconds if defined?(end_seconds)

      if mix_track.update(attrs)
        { mix_track: mix_track, errors: [] }
      else
        { mix_track: nil, errors: mix_track.errors.full_messages }
      end
    end
  end
end