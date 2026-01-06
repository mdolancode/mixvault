module Types
  class LabelType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false

    field :tracks, [Types::TrackType], null: false
  end
end