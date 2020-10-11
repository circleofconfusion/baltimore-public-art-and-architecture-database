import { ApolloServer } from 'apollo-server';
import { schema } from './schema.js';
import { resolvers } from './resolvers.js';
import { artworksByArtistIdsLoader } from './artwork.js';

const server = new ApolloServer({
  typeDefs: schema,
  resolvers,
  context: {
    loaders: {
      artworksByArtistIdsLoader: artworksByArtistIdsLoader()
    }
  }
});

server.listen().then(({url}) => {
  console.log(`🚀 Server ready at ${url}`);
});
