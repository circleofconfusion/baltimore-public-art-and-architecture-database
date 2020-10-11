import DataLoader from 'dataloader';
import { groupBy, map } from 'ramda';
import { query } from './db.js';

export async function getPersonById(id) {
  try {
    const res = await query('SELECT * FROM person WHERE id = $1', [id]);
    return res.rows[0];
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export async function getArtistsByArtworkIds(artworkIds) {
  try {
    const sql = 
      `SELECT a.*, aa."artworkId" FROM person a
      JOIN artist_artwork aa ON a.id = aa."artistId"
      JOIN artwork aw ON aw.id = aa."artworkId"
      WHERE aa."artworkId" = ANY($1)`;
    const res = await query(sql, [artworkIds]);
    const rowsById = groupBy(artist => artist.artworkId, res.rows);
    return map(id => rowsById[id] ? rowsById[id] : [], artworkIds)
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export function artistsByArtworkIdsLoader() {
  return new DataLoader(getArtistsByArtworkIds);
}

export async function getAllArtists() {
  try {
    const res = await query('SELECT * FROM person'); // TODO: This will return all persons, not just artists
    return res.rows;
  } catch (err) {
    console.error(err);
    throw err;
  }
}