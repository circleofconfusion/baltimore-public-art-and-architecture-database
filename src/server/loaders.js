import { 
  artworkArticlesByArtworkIdsLoader,
  artworksByArtistIdsLoader,
  artworkStarsByArtworkIdsLoader,
  imagesByArtworkIdsLoader
} from "./artwork.js";
import { artistsByArtworkIdsLoader, personsByIdsLoader } from './person.js';

export default {
  artworksByArtistIdsLoader: artworksByArtistIdsLoader(),
  artworkStarsByArtworkIdsLoader: artworkStarsByArtworkIdsLoader(),
  artworkArticlesByArtworkIdsLoader: artworkArticlesByArtworkIdsLoader(),
  imagesByArtworkIdsLoader: imagesByArtworkIdsLoader(),
  personsByIdsLoader: personsByIdsLoader(),
  artistsByArtworkIdsLoader: artistsByArtworkIdsLoader()
};