import { gql } from 'apollo-server';

export const SCHEMA = gql`
  interface Person {
    id: ID!
    firstName: String
    middleName: String
    lastName: String
    email: String
    imageUrl: String
    birthDate: Date
    deathDate: Date
  }

  type User implements Person {
    username: String!
  }

  type Artist implements Person {
    bio: String
    statement: String
  }

  type Artwork {
    id: ID!
    artists: [Artist]!
  }
`;