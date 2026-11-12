# frozen_string_literal: true

module Mutations
  class UpdateTrackInMix < Mutations::BaseMutation
    argument :mix_id, ID, required: true
    argument :track_id, ID, required: true
    argument :position, Integer, required: false
    argument :start_seconds, Integer, required: false
    argument :end_seconds, Integer, required: false

    field :mix_track, Types::MixTrackType, null: true
    field :errors, [ String ], null: false

    def resolve(mix_id:, track_id:, **args)
      mix = Mix.find_by(id: mix_id)
      return { mix_track: nil, errors: [ "Mix not found" ] } unless mix

      track = Track.find_by(id: track_id)
      return { mix_track: nil, errors: [ "Track not found" ] } unless track

      mix_track = MixTrack.find_by(mix_id: mix.id, track_id: track.id)
      return { mix_track: nil, errors: [ "Track is not in this mix" ] } unless mix_track

      attrs = {}
      attrs[:position] = args[:position] unless args[:position].nil?
      attrs[:start_seconds] = args[:start_seconds] unless args[:start_seconds].nil?
      # only touch end_seconds when the client sent it; an explicit null clears it
      attrs[:end_seconds] = args[:end_seconds] if args.key?(:end_seconds)

      if mix_track.update(attrs)
        { mix_track: mix_track, errors: [] }
      else
        { mix_track: nil, errors: mix_track.errors.full_messages }
      end
    end
  end
end
