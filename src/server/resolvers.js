import { getUserById, getArtworkById } from './db.js';

export const resolvers = {
  Query: {
    user(parent, args, context, info) {
      const { id } = args;
      return getUserById(id);
    },
    artwork(parent, args, context, info) {
      const { id } = args;
      return getArtworkById(id);
    }
  }
}