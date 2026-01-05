module Types
  class MixTrackType < Types::BaseObject
    field :id, ID, null: false
    field :position, Integer, null: true
    field :start_time_seconds, Integer, null: true

    field :mix, Types::MixType, null: false
    field :track, Types::TrackType, null: false
  end
end