import { query } from './db.js';
import { groupBy, map } from 'ramda';
import DataLoader from 'dataloader';

export async function getAllArtworks() {
  try {
    const res = await query('SELECT * FROM artwork');
    return res.rows;
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export async function getArtworkById(id) {
  try {
    const res = await query('SELECT * FROM artwork WHERE id = $1', [id]);
    return res.rows[0];
  } catch(err) {
    console.error(err);
    throw err;
  }
}

async function getArtworksByArtistIds(artistIds) {
  try {
    const sql = 
      `SELECT a.id, a.title, a.description, a.statement,
       ST_X(location::geometry) as longitude, ST_Y(location::geometry) as latitude,
       a.installation_date, a.updated, a.updated_by, artist_artwork.artist_id FROM artwork a
      JOIN artist_artwork  ON a.id = artist_artwork.artwork_id
      JOIN person ON person.id = artist_artwork.artist_id
      WHERE person.id = ANY($1)`;
    const res = await query(sql, [artistIds]);
    const rowsById = groupBy(artwork => artwork.artistId, res.rows);
    return map(id => rowsById[id] ? rowsById[id] : [], artistIds);
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export function artworksByArtistIdsLoader() {
  return new DataLoader(getArtworksByArtistIds);
}

async function getArtworkStarsByArtworkIds(artworkIds) {
  try {
    const sql = 
    `SELECT artwork_star.artwork_id, artwork_star.timestamp, person.* FROM artwork_star
    JOIN artwork ON artwork_star.artwork_id = artwork.id
    JOIN person ON artwork_star.person_id = person.id
    WHERE artwork_star.artwork_id = ANY($1)`;
    const res = await query(sql, [artworkIds]);
    const rowsById = groupBy(a => a.artwork_id, res.rows);
    const groupedRows = map(id => rowsById[id] ? rowsById[id] : [], artworkIds);
    return groupedRows;
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export function artworkStarsByArtworkIdsLoader() {
  return new DataLoader(getArtworkStarsByArtworkIds);
}

async function getArtworkArticlesByArtworkIds(artworkIds) {
  try {

  } catch(err) {
    console.error(err);
    throw err;
  }
}

export function artworkArticlesByArtworkIdsLoader() {
  return new DataLoader(getArtworkArticlesByArtworkIds);
}
