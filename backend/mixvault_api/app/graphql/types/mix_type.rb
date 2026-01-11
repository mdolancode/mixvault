module Types
  class MixType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false

    # Keep GraphQL naming camelCase, map to Rails attribute with `method:`
    field :recordedAt, GraphQL::Types::ISO8601DateTime, null: true, method: :recorded_at

    field :djName, String, null: false, method: :dj_name
    field :durationSeconds, Integer, null: false, method: :duration_seconds

    # Optional: friendly display like "60:00"
    field :duration, String, null: false

    field :label, Types::LabelType, null: true
    field :tracks, [Types::TrackType], null: true
    field :mix_tracks, [Types::MixTrackType], null: false

    def duration
      total = object.duration_seconds || 0
      minutes = total / 60
      seconds = total % 60
      format("%d:%02d", minutes, seconds)
    end
  end
end