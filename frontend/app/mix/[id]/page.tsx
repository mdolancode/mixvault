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
    <main style={{ padding: 24, fontFamily: "system-ui" }}>
      <h1 style={{ marginBottom: 6 }}>{mix.title}</h1>
      <div style={{ opacity: 0.7, marginBottom: 16 }}>
        {mix.djName} • {mix.duration}
      </div>

      <ol style={{ lineHeight: 1.6 }}>
        {mix.mixTracks.map((mt) => (
          <li key={mt.id}>
            <strong>
              {mt.startTimecode}
              {mt.endTimecode ? `–${mt.endTimecode}` : ""}
            </strong>{" "}
            — {mt.track.artist} – {mt.track.title}
            {mt.duration ? ` (${mt.duration})` : ""}
          </li>
        ))}
      </ol>
    </main>
  );
}