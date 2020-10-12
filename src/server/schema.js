import { gql } from 'apollo-server';

export const schema = gql`
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
    artworks: [Artwork]!
  }

  type Artwork {
    id: ID!
    title: String
    description: String
    statement: String
    longitude: Float
    latitude: Float
    installationDate: String
    updated: String
    updatedBy: ID!
    artists: [Artist]!
    stars: [Star]!
    articles: [Article]!
  }

  type Star {
    timestamp: String
    user: User!
  }

  type Article {
    id: ID!
    artworkId: ID!
    articleUrl: String
    articleTitle: String
    timestamp: String
    updatedBy: ID!
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