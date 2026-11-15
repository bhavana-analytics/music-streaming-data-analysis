1. Which music genres have the highest average popularity?

SELECT
    track_genre,
    ROUND(AVG(popularity), 2) AS average_popularity
FROM "music_streaming_dataset.csv"
GROUP BY track_genre
ORDER BY average_popularity DESC
LIMIT 10;

2. What are the top 10 most popular tracks?
SELECT
    track_name,
    artists,
    track_genre,
    popularity
FROM "music_streaming_dataset.csv"
ORDER BY popularity DESC
LIMIT 10;



3. Which artists have the highest average track popularity?


SELECT
    artists,
    ROUND(AVG(popularity), 2) AS average_popularity,
    COUNT(*) AS total_tracks
FROM "music_streaming_dataset.csv"
GROUP BY artists
HAVING COUNT(*) >= 5
ORDER BY average_popularity DESC
LIMIT 10;


4.IS danceability associated WITH popularity?
SELECT
    CASE
        WHEN danceability < 0.4 THEN 'Low Danceability'
        WHEN danceability < 0.7 THEN 'Medium Danceability'
        ELSE 'High Danceability'
    END AS danceability_category,

    COUNT(*) AS total_tracks,

    ROUND(AVG(popularity), 2) AS average_popularity

FROM "music_streaming_dataset.csv"

GROUP BY danceability_category

ORDER BY average_popularity DESC;

5.Which music genres have the highest average energy?

SELECT
    track_genre,
    ROUND(AVG(energy)::NUMERIC, 3) AS average_energy,
    COUNT(*) AS total_tracks
FROM "music_streaming_dataset.csv"
GROUP BY track_genre
ORDER BY average_energy DESC
LIMIT 10;

6 How does average track duration vary across music genres?
SELECT
    track_genre,
    ROUND(AVG(duration_ms) / 60000.0, 2) AS average_duration_minutes,
    COUNT(*) AS total_tracks
FROM "music_streaming_dataset.csv"
GROUP BY track_genre
ORDER BY average_duration_minutes DESC
LIMIT 10;

7 DO explicit tracks have higher average popularity than non-explicit tracks?
SELECT
    CASE
        WHEN explicit = TRUE THEN 'Explicit'
        ELSE 'Non-Explicit'
    END AS track_type,

    COUNT(*) AS total_tracks,

    ROUND(AVG(popularity)::NUMERIC, 2) AS average_popularity

FROM "music_streaming_dataset.csv"
GROUP BY track_type

ORDER BY average_popularity DESC;

8: Which tracks have high energy but low danceability?
SELECT
    track_name,
    artists,
    track_genre,
    energy,
    danceability,
    popularity
FROM "music_streaming_dataset.csv"
WHERE energy > 0.8
  AND danceability < 0.4
ORDER BY energy DESC
LIMIT 20;


9. Which genres have the highest average acousticness AND instrumentalness?
SELECT
    track_genre,
    ROUND(AVG(acousticness)::NUMERIC, 3) AS average_acousticness,
    ROUND(AVG(instrumentalness)::NUMERIC, 3) AS average_instrumentalness,
    COUNT(*) AS total_tracks
FROM "music_streaming_dataset.csv"
GROUP BY track_genre
ORDER BY average_instrumentalness DESC
LIMIT 10;

10.UESTION 10: What are the top 3 most popular tracks WITHIN EACH genre?
WITH ranked_tracks AS (
    SELECT
        track_name,
        artists,
        track_genre,
        popularity,

        ROW_NUMBER() OVER (
            PARTITION BY track_genre
            ORDER BY popularity DESC
        ) AS track_rank

    FROM "music_streaming_dataset.csv"
)

SELECT
    track_genre,
    track_rank,
    track_name,
    artists,
    popularity
FROM ranked_tracks
WHERE track_rank <= 3
ORDER BY track_genre, track_rank;

