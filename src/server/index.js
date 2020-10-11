import { ApolloServer } from 'apollo-server';
import { schema } from './schema.js';
import { resolvers } from './resolvers.js';
import { artworksByArtistIdsLoader } from './artwork.js';
import loaders from './loaders.js';

const server = new ApolloServer({
  typeDefs: schema,
  resolvers,
  context: { loaders }
});

server.listen().then(({url}) => {
  console.log(`🚀 Server ready at ${url}`);
});
