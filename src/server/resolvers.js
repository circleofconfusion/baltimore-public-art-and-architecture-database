import { getPersonById, getArtistsByArtworkIds, getAllArtists, artistsByArtworkIdsLoader } from './person.js';
import { getArtworkById, getAllArtworks } from './artwork.js';
export const resolvers = {
  Query: {
    user(parent, args, context, info) {
      const { id } = args;
      return getPersonById(id);
    },
    artwork(parent, args, context, info) {
      const { id } = args;
      return getArtworkById(id);
    },
    artworks(parent, args, context, info) {
      return getAllArtworks();
    },
    artist(parent, args, context, info) {
      return getPersonById(args.id);
    },
    artists() {
      return getAllArtists();
    }
  },
  Artwork: {
    artists(artwork, args, context, info) {
      const { loaders } = context;
      const { artistsByArtworkIdsLoader } = loaders;
      return artistsByArtworkIdsLoader.load(artwork.id);
    }
  },
  Artist: {
    artworks(parent, args, context) {
      const { loaders } = context;
      const { artworksByArtistIdsLoader } = loaders;
      return artworksByArtistIdsLoader.load(parent.id);
    }
  }
}