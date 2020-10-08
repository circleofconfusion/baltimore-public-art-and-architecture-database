import { query } from './db.js';

export async function getArtworkById(id) {
  try {
    const res = await query('SELECT * FROM artwork WHERE id = $1', [id]);
    return res.rows[0];
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export async function getArtworksByArtist(artistId) {
  try {
    const sql = 
      `SELECT aw.* FROM artwork aw
      JOIN artist_artwork aa ON aw.id = aa."artworkId"
      JOIN person a ON a.id = aa."artistId"
      WHERE a.id = $1`;
    const res = await query(sql, [artistId]);
    return res.rows;
  } catch(err) {
    console.error(err);
    throw err;
  }
}