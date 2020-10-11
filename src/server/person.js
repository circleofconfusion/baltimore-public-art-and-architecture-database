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

export async function getArtistsByArtwork(artworkId) {
  console.log('getArtistsByArtworks');
  try {
    const sql = 
      `SELECT a.* FROM person a
      JOIN artist_artwork aa ON a.id = aa."artistId"
      JOIN artwork aw ON aw.id = aa."artworkId"
      WHERE aa."artworkId" = $1`;
    const res = await query(sql, [artworkId]);
    return res.rows ? res.rows : [];
  } catch(err) {
    console.error(err);
    throw err;
  }
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