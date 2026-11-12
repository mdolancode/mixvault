# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_mix, mutation: Mutations::CreateMix
    field :add_track_to_mix, mutation: Mutations::AddTrackToMix
    field :update_track_in_mix, mutation: Mutations::UpdateTrackInMix
    field :remove_track_from_mix, mutation: Mutations::RemoveTrackFromMix
  end
end
