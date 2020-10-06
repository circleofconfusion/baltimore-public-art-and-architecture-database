import { ApolloServer } from 'apollo-server';
import { SCHEMA } from './schema.js';

const server = new ApolloServer({
  typeDefs: SCHEMA
});

server.listen().then(({url}) => {
  console.log(`🚀 Server ready at ${url}`);
});
