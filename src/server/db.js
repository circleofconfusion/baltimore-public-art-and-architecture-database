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
     client.release
  }
  return res.rows[0];
}
