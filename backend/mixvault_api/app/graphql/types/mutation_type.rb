# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_mix, mutation: Mutations::CreateMix
    field :add_track_to_mix, mutation: Mutations::AddTrackToMix
    field :update_track_in_mix, mutation: Mutations::UpdateTrackInMix
  end
end