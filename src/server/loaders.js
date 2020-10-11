import { artworksByArtistIdsLoader, artworkStarsByArtworkIdsLoader } from "./artwork.js";
import { artistsByArtworkIdsLoader } from './person.js';

export default {
  artworksByArtistIdsLoader: artworksByArtistIdsLoader(),
  artworkStarsByArtworkIdsLoader: artworkStarsByArtworkIdsLoader(),
  artistsByArtworkIdsLoader: artistsByArtworkIdsLoader()
};