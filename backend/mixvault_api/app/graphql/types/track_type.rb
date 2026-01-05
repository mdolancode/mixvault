module Types
  class TrackType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :artist, String, null: true
    field :bpm, Integer, null: true

    field :label, Types::LabelType, null: true
  end
end