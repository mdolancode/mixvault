module Types
  class MixType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :recorded_at, GraphQL::Types::ISO8601DateTime, null: true

    field :label, Types::LabelType, null: true
    field :tracks, [Types::TrackType], null: true
  end
end