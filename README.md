# Music Library Database Design

This database design transitions our music tracking from unstructured spreadsheets into a relational system. Our primary goal was solving data isolation issues where songs couldn’t belong to multiple playlists without row duplication. 

To resolve this, we designed a many-to-many bridge table (playlist_tracks) linking separate songs and playlists entities. We also included specialized attribute fields to satisfy our target stakeholders. This includes bpm fields for professional DJ tracking, an is_explicit validation column for venue store owners filtering content, and user metrics like star_rating and play_count for casual listeners. 

The main challenge was establishing clean table creation hierarchies so that external lookup values like artists and genres compile before downstream child entities. This structure ensures strict foreign key enforcement and prevents missing metadata fields across our entire collection.


----------------------------
## 👥 Authors & Contributors
----------------------------
This project was developed as a collaborated effort by 
*   **Kazan Waugh** ([GitHub Profile Link](https://github.com/kazanwaugh)) — Co-Creator & Lead Database Developer
*   **Sarah Weiss** ([GitHub Profile Link](https://github.com/https://github.com/sarahweiss16)) — Co-Creator & Lead Database Developer <br>
Both authors contributed equally to the design, implementation, and optimization of this Music Database Project.
