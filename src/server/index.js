import { ApolloServer } from 'apollo-server';
import { schema } from './schema.js';
import { resolvers } from './resolvers.js';

const server = new ApolloServer({
  typeDefs: schema,
  resolvers
});

server.listen().then(({url}) => {
  console.log(`🚀 Server ready at ${url}`);
});
