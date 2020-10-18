import DataLoader from 'dataloader';
import { groupBy, map } from 'ramda';
import { query } from './db.js';
import humps from 'humps';

export async function getPersonById(id) {
  try {
    const sql = `
    'SELECT * FROM person WHERE id = $1'`;
    const res = await query(sql, [id]);
    return humps.camelizeKeys(res.rows[0]);
  } catch(err) {
    console.error(err);
    throw err;
  }
}

async function getPersonsByIds(ids) {
  try {
    const res = await query('SELECT * FROM person WHERE id = ANY($1)', [ids]);
    const rows = humps.camelizeKeys(res.rows);
    const rowsById = groupBy(p => p.id, rows);
    const groupedRows = map(id => rowsById[id][0], ids);
    return groupedRows;
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export function personsByIdsLoader() {
  return new DataLoader(getPersonsByIds);
}

export async function getArtistsByArtworkIds(artworkIds) {
  try {
    const sql = 
      `SELECT a.*, aa.artwork_id FROM person a
      JOIN artist_artwork aa ON a.id = aa.artist_id
      JOIN artwork aw ON aw.id = aa.artwork_id
      WHERE aa.artwork_id = ANY($1)`;
    const res = await query(sql, [artworkIds]);
    const rows = humps.camelizeKeys(res.rows);
    const rowsById = groupBy(artist => artist.artworkId, rows);
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
    return humps.camelizeKeys(res.rows);
  } catch (err) {
    console.error(err);
    throw err;
  }
}