import { 
  artworkArticlesByArtworkIdsLoader,
  artworksByArtistIdsLoader,
  artworkStarsByArtworkIdsLoader
} from "./artwork.js";
import { artistsByArtworkIdsLoader } from './person.js';

export default {
  artworksByArtistIdsLoader: artworksByArtistIdsLoader(),
  artworkStarsByArtworkIdsLoader: artworkStarsByArtworkIdsLoader(),
  artworkArticlesByArtworkIdsLoader: artworkArticlesByArtworkIdsLoader(),
  artistsByArtworkIdsLoader: artistsByArtworkIdsLoader()
};