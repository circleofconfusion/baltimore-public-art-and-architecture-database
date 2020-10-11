import { artworksByArtistIdsLoader } from "./artwork.js";
import { artistsByArtworkIdsLoader } from './person.js';

export default {
  artworksByArtistIdsLoader: artworksByArtistIdsLoader(),
  artistsByArtworkIdsLoader: artistsByArtworkIdsLoader()
};