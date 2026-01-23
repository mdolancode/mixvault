import { gql } from "@/lib/graphql";
import { MIX_QUERY } from "@/lib/queries";

type MixTrack = {
  id: string;
  position: number;
  startSeconds: number;
  endSeconds?: number | null;
  startTimecode: string;
  endTimecode?: string | null;
  duration?: string | null;
  track: { title: string; artist: string };
};

type Mix = {
  id: string;
  title: string;
  djName: string;
  duration: string;
  mixTracks: MixTrack[];
};

type MixQueryData = { mix: Mix | null };

export default async function MixPage({
  params,
}: {
  params: { id: string };
}) {

  const { id } = await params;

  const data = await gql<MixQueryData>(MIX_QUERY, { id });

  if (!data.mix) return <div>Mix not found</div>;

  const { mix } = data;

  return (
<main style={{ padding: 24, fontFamily: "system-ui", maxWidth: 720 }}>
      <h1 style={{ marginBottom: 6 }}>{mix.title}</h1>

      <div style={{ opacity: 0.75, marginBottom: 8 }}>
        {mix.djName} • {mix.duration}
      </div>

      {/* 1) Track count */}
      <div style={{ opacity: 0.75, marginBottom: 16 }}>
        {trackCount} {trackCount === 1 ? "track" : "tracks"}
      </div>

      {/* 3) Empty state */}
      {trackCount === 0 ? (
        <div
          style={{
            border: "1px solid rgba(255,255,255,0.12)",
            borderRadius: 12,
            padding: 16,
            opacity: 0.9,
          }}
        >
          <div style={{ fontWeight: 600, marginBottom: 6 }}>
            No tracks yet
          </div>
          <div style={{ opacity: 0.75 }}>
            Add tracks to this mix to see a timestamped tracklist here.
          </div>
        </div>
      ) : (
        <ol style={{ lineHeight: 1.7, paddingLeft: 18 }}>
          {mix.mixTracks.map((mt) => (
            <li key={mt.id} style={{ marginBottom: 10 }}>
              <div>
                <strong>
                  {mt.startTimecode}
                  {mt.endTimecode ? `–${mt.endTimecode}` : ""}
                </strong>{" "}
                — {mt.track.artist} – {mt.track.title}
              </div>

              {/* 2) Per-track duration */}
              {mt.duration ? (
                <div style={{ opacity: 0.75, fontSize: 14 }}>
                  Duration: {mt.duration}
                </div>
              ) : null}
            </li>
          ))}
        </ol>
      )}
    </main>
  );
}