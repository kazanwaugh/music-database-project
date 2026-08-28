-- ========================================================
-- FILE 2: TESTING QUERIES AND VIEWS
-- ========================================================

USE music_library_db;

-- QUERY 1: THE PROFESSIONAL DJ SEARCH
SELECT s.song_name, a.artist_name, s.bpm
FROM songs s
JOIN albums al ON s.album_id = al.album_id
JOIN artists a ON al.artist_id = a.artist_id
WHERE s.bpm > 120;

-- QUERY 2: THE STORE OWNER FILTER
SELECT s.song_name, g.genre_name, s.is_explicit
FROM songs s
JOIN genres g ON s.genre_id = g.genre_id
WHERE s.is_explicit = 0 AND g.genre_name = 'Pop';

-- QUERY 3: PLAYLIST CONTEXT MANIFEST
SELECT p.playlist_name, s.song_name, a.artist_name
FROM playlists p
JOIN playlist_tracks pt ON p.playlist_id = pt.playlist_id
JOIN songs s ON pt.song_id = s.song_id
JOIN albums al ON s.album_id = al.album_id
JOIN artists a ON al.artist_id = a.artist_id
WHERE p.playlist_name = 'Heavy Cardio Blast';

-- QUERY 4: CASUAL FAN ANALYTICS
SELECT a.artist_name, SUM(s.play_count) AS total_listens
FROM songs s
JOIN albums al ON s.album_id = al.album_id
JOIN artists a ON al.artist_id = a.artist_id
GROUP BY a.artist_name;

-- VIEW 1: MASTER_LIBRARY_CATALOG
CREATE OR REPLACE VIEW view_master_library_catalog AS
SELECT s.song_id, s.song_name, a.artist_name, al.album_name, g.genre_name, s.bpm
FROM songs s
JOIN genres g ON s.genre_id = g.genre_id
JOIN albums al ON s.album_id = al.album_id
JOIN artists a ON al.artist_id = a.artist_id;

-- VIEW 2: SAFE_RETAIL_PLAYLISTS
CREATE OR REPLACE VIEW view_safe_retail_playlists AS
SELECT song_id, song_name, bpm, star_rating
FROM songs
WHERE is_explicit = 0;
