# frozen_string_literal: true

module Mutations
  class RemoveTrackFromMix < Mutations::BaseMutation
    argument :mix_id, ID, required: true
    argument :track_id, ID, required: true

    field :success, Boolean, null: false
    field :errors, [ String ], null: false

    def resolve(mix_id:, track_id:)
      mix = Mix.find_by(id: mix_id)
      return { success: false, errors: [ "Mix not found" ] } unless mix

      mix_track = mix.mix_tracks.find_by(track_id: track_id)
      return { success: false, errors: [ "Track not found in mix" ] } unless mix_track

      mix_track.destroy

      { success: true, errors: [] }
    end
  end
end
