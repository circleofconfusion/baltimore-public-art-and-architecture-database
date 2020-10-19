import { query } from './db.js';
import { groupBy, map } from 'ramda';
import DataLoader from 'dataloader';
import humps from 'humps';

export async function getAllArtworks() {
  try {
    const sql =
    `SELECT a.id, a.title, a.description, a.statement,
    ST_X(location::geometry) as longitude, ST_Y(location::geometry) as latitude,
    a.installation_date, a.updated, a.updated_by
    FROM artwork a`;
    const res = await query(sql);
    return humps.camelizeKeys(res.rows);
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export async function getArtworkById(id) {
  try {
    const sql =
    `SELECT a.id, a.title, a.description, a.statement,
    ST_X(location::geometry) as longitude, ST_Y(location::geometry) as latitude,
    a.installation_date, a.updated, a.updated_by
    FROM artwork a
    WHERE id = $1`;
    const res = await query(sql, [id]);
    return humps.camelizeKeys(res.rows[0]);
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
    const rows = humps.camelizeKeys(res.rows);
    const rowsById = groupBy(artwork => artwork.artistId, rows);
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
    const rows = humps.camelizeKeys(res.rows);
    const rowsById = groupBy(a => a.artworkId, rows);
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
    const sql =
    `SELECT aa.* FROM artwork_article aa WHERE aa.artwork_id = ANY($1)`;
    const res = await query(sql, [artworkIds]);
    const rows = humps.camelizeKeys(res.rows);
    const rowsById = groupBy(a => a.artworkId, rows);
    const groupedRows = map(id => rowsById[id] ? rowsById[id] : [], artworkIds);
    return groupedRows;
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export function artworkArticlesByArtworkIdsLoader() {
  return new DataLoader(getArtworkArticlesByArtworkIds);
}

async function getImagesByArtworkIds(artworkIds) {
  try {
    const sql = `SELECT ai.* FROM artwork_image ai WHERE ai.artwork_id = ANY($1)`;
    const res = await query(sql, [artworkIds]);
    const rows = humps.camelizeKeys(res.rows);
    const rowsById = groupBy(a => a.artworkId, rows);
    const groupedRows = map(id => rowsById[id] ? rowsById[id] : [], artworkIds);
    return groupedRows;
  } catch(err) {
    console.error(err);
    throw err;
  }
}

export function imagesByArtworkIdsLoader() {
  return new DataLoader(getImagesByArtworkIds);
}

export async function createArtwork(artworkInput) {
  const { title, description, statement, longitude, latitude, installation_date} = artworkInput;
  const updated_by = 1; // TODO: Base this on a JWT found in the context object.
  const sql = `
    INSERT INTO artwork
    (title, description, statement, location, installation_date, updated_by)
    VALUES($1, $2, $3, ST_SetSRID(ST_MakePoint($4, $5), 4326), $6, $7)
    RETURNING *`;
  const params = [ title, description, statement, longitude, latitude, installation_date, updated_by ];
  try {
    const result = await query(sql, params);
    return result.rows[0];
  } catch(err) {
    console.error(err);
    throw err;
  }
}