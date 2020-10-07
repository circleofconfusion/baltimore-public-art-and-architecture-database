import { getUserById, getArtworkById, getArtistsByArtwork, getArtworksByArtist } from './db.js';

export const resolvers = {
  Query: {
    user(parent, args, context, info) {
      const { id } = args;
      return getUserById(id);
    },
    artwork(parent, args, context, info) {
      const { id } = args;
      return getArtworkById(id);
    },
    artist(parent, args, context, info) {
      return getUserById(args.id);
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