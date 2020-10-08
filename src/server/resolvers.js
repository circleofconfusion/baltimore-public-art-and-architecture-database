import { getPersonById, getArtistsByArtwork } from './person.js';
import { getArtworkById, getArtworksByArtist } from './artwork.js';
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
    artist(parent, args, context, info) {
      return getPersonById(args.id);
    }
  },
  Artwork: {
    artists(parent, args, context, info) {
      return getArtistsByArtwork(parent.id);
    }
  },
  Artist: {
    artworks(parent, args, context, info) {
      return getArtworksByArtist(parent.id);
    }
  }
}