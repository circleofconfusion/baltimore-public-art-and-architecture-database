import dotenv from 'dotenv';
import pg from 'pg';

dotenv.config();

const { Pool } = pg;
const pool = new Pool();

export async function query(sql, params) {
  console.log('running query');
  const client = await pool.connect();
  try {
    return client.query(sql, params);
  } catch(err) {
    console.log(err);
    throw err;
  } finally {
    client.release();
  }
}
