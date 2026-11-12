module Types
  class TrackType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :artist, String, null: false
    field :bpm, Integer, null: false
    field :duration_seconds, Integer, null: false

    field :duration_formatted, String, null: false

      def duration_formatted
      minutes = object.duration_seconds / 60
      seconds = object.duration_seconds % 60
      format("%d:%02d", minutes, seconds)
    end

    field :label, Types::LabelType, null: false
  end
end
