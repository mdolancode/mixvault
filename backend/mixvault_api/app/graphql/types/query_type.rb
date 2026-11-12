# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Optional: keep this only if you're using Relay Node IDs
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, GraphQL::Types::ID, required: true, description: "ID of the object."
    end

    # Labels
    field :labels, [ Types::LabelType ], null: false
    def labels
      Label.all
    end

    # Tracks
    field :tracks, [ Types::TrackType ], null: false
    def tracks
      Track.all
    end

    # Mixes
    field :mixes, [ Types::MixType ], null: false

    field :mix, Types::MixType, null: true do
      argument :id, ID, required: true
    end

    def mixes
      Mix.all
    end

    def mix(id:)
      Mix.find_by(id: id)
    end
  end
end

# TODO: Add filters / pagination later
