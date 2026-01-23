export const MIX_QUERY = /* GraphQL */ `
  query Mix($id: ID!) {
    mix(id: $id) {
      id
      title
      djName
      duration
      mixTracks {
        id
        position
        startSeconds
        endSeconds
        startTimecode
        endTimecode
        duration
        track {
          title
          artist
        }
      }
    }
  }
`;