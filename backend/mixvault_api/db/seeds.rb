MixTrack.delete_all
Mix.delete_all
Track.delete_all
Label.delete_all

libertas = Label.create!(name: "Libertas Music")
mango = Label.create!(name: "Mango Alley")

t1 = Track.create!(
  title: "Breath of Life (Papa Kuma Remix)",
  artist: "Papa Kuma",
  bpm: 122,
  label: libertas,
  isrc: "MOCKISRC001",
  pool_eligible: true
)

t2 = Track.create!(
  title: "Coil",
  artist: "Dowden & Ric Niels",
  bpm: 124,
  label: mango,
  isrc: "MOCKISRC002",
  pool_eligible: true
)

t3 = Track.create!(
  title: "Outside Pool Track",
  artist: "Someone Else",
  bpm: 120,
  label: libertas,
  isrc: "MOCKISRC003",
  pool_eligible: false
)

mix = Mix.create!(
  title: "MixVault Demo Session 001",
  dj_name: "Papa Kuma",
  duration_seconds: 3600,
  audio_url: "/uploads/mock_mix_001.mp3",
  status: :draft,
  recorded_at: Time.current
)

MixTrack.create!(mix: mix, track: t1, position: 1, start_seconds: 0)
MixTrack.create!(mix: mix, track: t2, position: 2, start_seconds: 480)
