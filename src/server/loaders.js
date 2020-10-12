import { 
  artworkArticlesByArtworkIdsLoader,
  artworksByArtistIdsLoader,
  artworkStarsByArtworkIdsLoader,
  imagesByArtworkIdsLoader
} from "./artwork.js";
import { artistsByArtworkIdsLoader } from './person.js';

export default {
  artworksByArtistIdsLoader: artworksByArtistIdsLoader(),
  artworkStarsByArtworkIdsLoader: artworkStarsByArtworkIdsLoader(),
  artworkArticlesByArtworkIdsLoader: artworkArticlesByArtworkIdsLoader(),
  imagesByArtworkIdsLoader: imagesByArtworkIdsLoader(),
  artistsByArtworkIdsLoader: artistsByArtworkIdsLoader()
};