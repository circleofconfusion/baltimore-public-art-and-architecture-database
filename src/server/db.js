import dotenv from 'dotenv';
dotenv.config();

import pg from 'pg';
const { Pool } = pg;

const pool = new Pool();

console.log('pool created');

export async function getUserById(id) {
  const client = await pool.connect();
  let res;
  try {
    res = await client.query('SELECT * FROM person WHERE id = $1', [id]);
  } catch(err) {
    console.error(err);
  } finally {
    client.release();
  }
  return res.rows[0];
}

export async function getArtworkById(id) {
  const client = await pool.connect();
  let res;
  try {
    res = await client.query('SELECT * FROM artwork WHERE id = $1', [id]);
  } catch(err) {
    console.error(err);
  } finally {
     client.release()
  }
  return res.rows[0];
}

export async function getArtistsByArtwork(artworkId) {
  const client = await pool.connect();
  let res;
  try {
    res = await client.query('SELECT a.* FROM person a JOIN artist_artwork aa ON a.id = aa."artistId" JOIN artwork aw ON aw.id = aa."artworkId" WHERE aa."artworkId" = $1', [artworkId]);
  } catch(err) {
    console.error(err);
  } finally {
    client.release();
  }
  return res.rows;
}

export async function getArtworksByArtist(artistId) {
  const client = await pool.connect();
  let res;
  try {
    res = await client.query('SELECT aw.* FROM artwork aw JOIN artist_artwork aa ON aw.id = aa."artworkId" JOIN person a ON a.id = aa."artistId" WHERE a.id = $1', [artistId]);
  } catch(err) {
    console.error(err);
  } finally {
    client.release();
  }
  return res.rows;
}
