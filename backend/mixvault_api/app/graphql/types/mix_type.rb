module Types
  class MixType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false

    field :recorded_at, GraphQL::Types::ISO8601DateTime, null: true
    field :dj_name, String, null: false
    field :duration_seconds, Integer, null: false
    field :duration, String, null: false

    field :label, Types::LabelType, null: true
    field :tracks, [Types::TrackType], null: true
    field :mix_tracks, [Types::MixTrackType], null: false

    def mix_tracks
      object.mix_tracks.order(:position)
    end

    def duration
      total = object.duration_seconds || 0
      minutes = total / 60
      seconds = total % 60
      format("%d:%02d", minutes, seconds)
    end
  end
end