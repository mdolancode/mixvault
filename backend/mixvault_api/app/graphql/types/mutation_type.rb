# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_mix, mutation: Mutations::CreateMix
    field :add_track_to_mix, mutation: Mutations::AddTrackToMix
  end
end
