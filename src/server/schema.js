import { gql } from 'apollo-server';

export const SCHEMA = gql`
  interface Person {
    id: ID!
    firstName: String
    middleName: String
    lastName: String
    email: String
    imageUrl: String
    birthDate: String
    deathDate: String
    updated: String
    updatedBy: ID!
  }

  type User implements Person {
    id: ID!
    firstName: String
    middleName: String
    lastName: String
    email: String
    imageUrl: String
    birthDate: String
    deathDate: String
    updated: String
    updatedBy: ID!
    username: String!
  }

  type Artist implements Person {
    id: ID!
    firstName: String
    middleName: String
    lastName: String
    email: String
    imageUrl: String
    birthDate: String
    deathDate: String
    updated: String
    updatedBy: ID!
    bio: String
    website: String
  }

  type Artwork {
    id: ID!
    # artists: [Artist]
  }

  type Query {
    users: [User]!
    user(id: ID!): User
    artists: [Artist]!
    artist(id: ID!): Artist
    artworks: [Artwork]!
    artwork(id: ID!): Artwork
  }
`;