require "test_helper"

class MixTrackTest < ActiveSupport::TestCase
  setup do
    label = Label.create!(name: "Test Label")
    @mix = Mix.create!(title: "Test Mix", dj_name: "DJ Test", duration_seconds: 600)
    @track_one = Track.create!(label: label, title: "One", artist: "Artist", bpm: 128)
    @track_two = Track.create!(label: label, title: "Two", artist: "Artist", bpm: 128)
  end

  test "rejects end_seconds after the next track's start_seconds" do
    MixTrack.create!(mix: @mix, track: @track_two, position: 2, start_seconds: 100)

    mix_track = MixTrack.new(mix: @mix, track: @track_one, position: 1, start_seconds: 0, end_seconds: 150)

    assert_not mix_track.valid?
    assert_includes mix_track.errors[:end_seconds].join, "must be <= next track start time"
  end

  test "accepts end_seconds equal to the next track's start_seconds" do
    MixTrack.create!(mix: @mix, track: @track_two, position: 2, start_seconds: 100)

    mix_track = MixTrack.new(mix: @mix, track: @track_one, position: 1, start_seconds: 0, end_seconds: 100)

    assert mix_track.valid?, mix_track.errors.full_messages.to_sentence
  end

  test "rejects last track end_seconds beyond the mix duration" do
    mix_track = MixTrack.new(mix: @mix, track: @track_one, position: 1, start_seconds: 0, end_seconds: 601)

    assert_not mix_track.valid?
    assert_includes mix_track.errors[:end_seconds].join, "must be <= mix duration (600s)"
  end

  test "accepts last track end_seconds when the mix duration is not set" do
    @mix.update!(duration_seconds: nil)

    mix_track = MixTrack.new(mix: @mix, track: @track_one, position: 1, start_seconds: 0, end_seconds: 99_999)

    assert mix_track.valid?, mix_track.errors.full_messages.to_sentence
  end
end
