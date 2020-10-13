import { getPersonById, getArtistsByArtworkIds, getAllArtists, artistsByArtworkIdsLoader } from './person.js';
import { getArtworkById, getAllArtworks } from './artwork.js';
export const resolvers = {
  Query: {
    user(parent, args, context) {
      const { id } = args;
      return getPersonById(id);
    },
    artwork(parent, args, context) {
      const { id } = args;
      return getArtworkById(id);
    },
    artworks(parent, args, context) {
      return getAllArtworks();
    },
    artist(parent, args, context) {
      return getPersonById(args.id);
    },
    artists() {
      return getAllArtists();
    }
  },
  Artwork: {
    artists(artwork, args, context) {
      const { loaders } = context;
      const { artistsByArtworkIdsLoader } = loaders;
      return artistsByArtworkIdsLoader.load(artwork.id);
    },
    stars(artwork, args, context) {
      const { loaders } = context;
      const { artworkStarsByArtworkIdsLoader } = loaders;
      return artworkStarsByArtworkIdsLoader.load(artwork.id);
    },
    articles(artwork, args, context) {
      const { loaders } = context;
      const { artworkArticlesByArtworkIdsLoader } = loaders;
      return artworkArticlesByArtworkIdsLoader.load(artwork.id);
    },
    images(artwork, args, context) {
      const { loaders } = context;
      const { imagesByArtworkIdsLoader } = loaders;
      return imagesByArtworkIdsLoader.load(artwork.id);
    },
    updatedBy(artwork, args, context) {
      const { loaders } = context;
      const { personsByIdsLoader } = loaders;
      return personsByIdsLoader.load(artwork.updatedBy);
    }
  },
  Artist: {
    artworks(parent, args, context) {
      const { loaders } = context;
      const { artworksByArtistIdsLoader } = loaders;
      return artworksByArtistIdsLoader.load(parent.id);
    },
    updatedBy(artist, args, context) {
      const { loaders } = context;
      const { personsByIdsLoader } = loaders;
      return personsByIdsLoader.load(artist.updatedBy);
    }
  },
  Star: {
    user(star, args, context, info) {
      return {
        id: star.id,
        firstName: star.firstName,
        middleName: star.middleName,
        lastName: star.lastName,
        email: star.email,
        imageUrl: star.imageUrl,
        birthDate: star.birthDate,
        deathDate: star.deathDate,
        updated: star.updated,
        updatedBy: star.updatedBy,
        username: star.username
      }
    }
  },
  Article: {
    updatedBy(article, args, context) {
      const { loaders } = context;
      const { personsByIdsLoader } = loaders;
      return personsByIdsLoader.load(article.updatedBy);
    }
  },
  ArtworkImage: {
    uploadedBy(artworkImage, args, context) {
      const { loaders } = context;
      const { personsByIdsLoader } = loaders;
      return personsByIdsLoader.load(artworkImage.uploadedBy);
    }
  }
}