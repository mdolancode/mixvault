module Types
  class MixTrackType < Types::BaseObject
    field :id, ID, null: false
    field :position, Integer, null: false
    field :start_seconds, Integer, null: false
    field :end_seconds, Integer, null: true

    field :start_timecode, String, null: false
    field :end_timecode, String, null: true
    field :duration_seconds, Integer, null: true
    field :duration, String, null: true

    field :track, Types::TrackType, null: false

    def start_timecode
      seconds_to_timecode(object.start_seconds)
    end

    def end_timecode
      object.end_seconds && seconds_to_timecode(object.end_seconds)
    end

    def duration_seconds
      object.end_seconds && (object.end_seconds - object.start_seconds)
    end

    def duration
      ds = duration_seconds
      ds && seconds_to_timecode(ds)
    end

    private

    def seconds_to_timecode(total)
      m = total / 60
      s = total % 60
      format("%d:%02d", m, s)
    end
  end
end