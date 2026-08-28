-- ========================================================
-- FILE 1: DATABASE STRUCTURE AND SEED DATA
-- ========================================================

CREATE DATABASE IF NOT EXISTS music_library_db;
USE music_library_db;

-- 1. Create Lookup Tables (With Safety Triggers)
CREATE TABLE IF NOT EXISTS artists (
    artist_id INT AUTO_INCREMENT,
    artist_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (artist_id)
);

CREATE TABLE IF NOT EXISTS genres (
    genre_id INT AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (genre_id)
);

CREATE TABLE IF NOT EXISTS playlists (
    playlist_id INT AUTO_INCREMENT,
    playlist_name VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id)
);

-- 2. Create Dependent Tables
CREATE TABLE IF NOT EXISTS albums (
    album_id INT AUTO_INCREMENT,
    album_name VARCHAR(150) NOT NULL,
    release_year INT NULL,
    artist_id INT NOT NULL,
    PRIMARY KEY (album_id),
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE IF NOT EXISTS songs (
    song_id INT AUTO_INCREMENT,
    song_name VARCHAR(150) NOT NULL,
    bpm INT NULL,
    is_explicit INT DEFAULT 0,
    star_rating INT NULL,
    play_count INT DEFAULT 0,
    album_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (song_id),
    FOREIGN KEY (album_id) REFERENCES albums(album_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

-- 3. Create Bridge Table
CREATE TABLE IF NOT EXISTS playlist_tracks (
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    PRIMARY KEY (playlist_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

-- 4. Insert Data (Using IGNORE so it won't duplicate rows)
INSERT IGNORE INTO genres (genre_id, genre_name) VALUES 
(1, 'Dance / Disco'), (2, 'Hip Hop'), (3, 'Rock'), (4, 'Pop'), (5, 'Alternative');

INSERT IGNORE INTO artists (artist_id, artist_name) VALUES 
(1, 'Daft Punk'), (2, 'Drake'), (3, 'Queen'), (4, 'Dua Lipa'), (5, 'Billie Eilish');

INSERT IGNORE INTO albums (album_id, album_name, release_year, artist_id) VALUES 
(1, 'Discovery', 2001, 1),
(2, 'Homework', 1997, 1),
(3, 'Take Care', 2011, 2),
(4, 'Scorpion', 2018, 2),
(5, 'A Night at the Opera', 1975, 3),
(6, 'Future Nostalgia', 2020, 4),
(7, 'Hit Me Hard and Soft', 2024, 5);

INSERT IGNORE INTO songs (song_id, song_name, bpm, is_explicit, star_rating, play_count, album_id, genre_id) VALUES 
(1, 'One More Time', 123, 0, 5, 120, 1, 1),
(2, 'Around the World', 121, 0, 4, 95, 2, 1),
(3, 'Headlines', 152, 1, 5, 210, 3, 2),
(4, 'Gods Plan', 154, 1, 4, 315, 4, 2),
(5, 'Bohemian Rhapsody', 143, 0, 5, 450, 5, 3),
(6, 'Don''t Start Now', 124, 0, 4, 280, 6, 4),
(7, 'Lunch', 120, 0, 5, 190, 7, 5);

INSERT IGNORE INTO playlists (playlist_id, playlist_name) VALUES 
(1, 'Coffee Shop Morning Vibe'),
(2, 'Heavy Cardio Blast'),
(3, 'Late Night Club Set');

INSERT IGNORE INTO playlist_tracks (playlist_id, song_id) VALUES 
(1, 6), (1, 7), 
(2, 3), (2, 4), 
(3, 1), (3, 2);