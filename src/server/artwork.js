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

export async function getArtworksByArtistIds(artistIds) {
  try {
    const sql = 
      `SELECT a.id, a.title, a.description, a.statement,
       ST_X(location::geometry) as longitude, ST_Y(location::geometry) as latitude,
       a."installationDate", a.updated, a."updatedBy", artist_artwork."artistId" FROM artwork a
      JOIN artist_artwork  ON a.id = artist_artwork."artworkId"
      JOIN person ON person.id = artist_artwork."artistId"
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