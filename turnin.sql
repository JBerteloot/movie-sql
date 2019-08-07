--Select all columns and rows from the movies table
SELECT *
FROM movies

--Select only the title and id of the first 10 rows
SELECT id, title
FROM movies
LIMIT 10

--Find the movie with the id of 485
SELECT id, title
FROM movies
WHERE id = 485


--Find the id (only that column) of the movie Made in America (1993)
SELECT id
FROM movies
WHERE title = "Made in America (1993)"

--Find the first 10 sorted alphabetically
SELECT *
FROM movies
ORDER BY title ASC
LIMIT 10

--Find all movies from 2002
SELECT *
FROM movies
WHERE title LIKE '%2002%'

--Find out what year the Godfather came out
SELECT title
FROM movies
WHERE title LIKE '%Godfather, The%'

--Without using joins find all the comedies
SELECT *
FROM movies
WHERE genres LIKE 'Comedy'

--Find all comedies in the year 2000
SELECT *
FROM movies
WHERE genres LIKE 'Comedy' AND title LIKE '%2000%'

--Find any movies that are about death and are a comedy
SELECT *
FROM movies
WHERE genres LIKE 'Comedy' AND title LIKE '%death%'

--Find any movies from either 2001 or 2002 with a title containing super
SELECT *
FROM movies
WHERE (title LIKE '%2001%' AND  title LIKE "%super%") OR (title LIKE "%super%" AND title LIKE '%2002%')

--Create a new table called actors (We are going to pretend the actor can only play in one movie). The table should include name, character name, foreign key to movies and date of birth at least plus an id field.

INSERT INTO actors (id, name, dob, character_name, movie_id)

--Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements

INSERT INTO actors (name, dob, character_name, movie_id)
VALUES ("Tim Robbins", '1958-10-16', "Andy Dufresne", 318),
		("Morgan Freeman", '1937-06-01', "Ellis Boyd Red Redding", 318),
		("Bob Gunton", '1945-11-15', "Warden Norton", 318),
		('William Sadler', '1950-04-13', "Heywood", 318),
		('Tom Hanks', '1956-07-09', 'Forrest Gump', 356),
		('Robin Wright', '1966-04-08', 'Jenny Curran', 356), 
		('Sally Field', '1946-11-06', 'Mrs Gump', 356),
		('Gary Sinise', '1955-03-17', 'Lieutenant Dan Taylor', 356),
    ('John Travolta', '1954-02-18', 'Vincent Vega', 296), 
		('Samuel L. Jackson', '1948-12-21', 'Jules Winnfield', 296),
		('Bruce Willis', '1955-03-19', 'Butch Coolidge', 296),
		('Uma Thurman', '1970-04-29', 'Mia Wallace', 296)


--Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating
UPDATE movies 
SET mpaa_rating = "G" WHERE id = 1
UPDATE movies
SET mpaa_rating = "PG-13" WHERE id = 2
UPDATE movies
SET mpaa_rating = "PG-13" WHERE id = 3
UPDATE movies
SET mpaa_rating = "R" WHERE id = 4
UPDATE movies
SET mpaa_rating = "PG" WHERE id = 5


---**********---
--WITH JOINS--
--Find all the ratings for the movie Godfather, show just the title and the rating
SELECT movies.title, ratings.rating
FROM movies
LEFT JOIN ratings ON movies.id = ratings.movie_id
WHERE movies.title LIKE '%godfather%' AND movies.title LIKE '%1972%'

--Order the previous objective by newest to oldest
SELECT movies.title, ratings.rating
FROM movies
LEFT JOIN ratings ON movies.id = ratings.movie_id
WHERE movies.title LIKE '%godfather%' AND movies.title LIKE '%1972%'
ORDER BY ratings.timestamp DESC


--Find the comedies from 2005 and get the title and imdbid from the links table
SELECT movies.title, links.imdb_Id
FROM links
LEFT JOIN movies ON movies.id = links.movie_id
WHERE movies.genres LIKE 'comedy' AND movies.title LIKE '%2005%'

--Find all movies that have no ratings
SELECT movies.title, ratings.rating
FROM ratings
LEFT JOIN movies ON movies.id = ratings.movie_id
WHERE ratings.rating IS NULL

---**********---
--AGGREGATION OBJECTIVES

-- Get the average rating for a movie
SELECT movies.id, AVG(ratings.rating), movies.title
FROM ratings
LEFT JOIN movies ON movies.id = ratings.movie_id
GROUP BY movies.id, movies.title

-- Get the total ratings for a movie
SELECT movies.id, SUM(ratings.rating), movies.title
FROM ratings
LEFT JOIN movies ON movies.id = ratings.movie_id
GROUP BY movies.id, movies.title

-- Get the total movies for a genre
SELECT movies.genres, SUM(movies.title)
FROM movies
GROUP BY movies.genres

-- Get the average rating for a user
SELECT user_id, AVG(ratings.rating)
FROM ratings
GROUP BY user_id

-- Find the user with the most ratings
SELECT user_id,  COUNT(rating) as NumberOfRatings
FROM ratings
GROUP BY user_id
ORDER BY NumberOfRatings DESC

-- Find the user with the highest average rating
SELECT user_id,  AVG(rating) as RatingAVG
FROM ratings
GROUP BY user_id
ORDER BY RatingAVG DESC

-- Find the user with the highest average rating with more than 50 reviews
SELECT user_id,  AVG(rating) as RatingAVG, COUNT(rating) as NumberOfRatings
FROM ratings
GROUP BY user_id
HAVING NumberOfRatings > 50
ORDER BY RatingAVG DESC

-- Find the movies with an average rating over 4
SELECT m.title, AVG(r.rating) as RatingAVG
FROM ratings r
LEFT JOIN movies m ON m.id = r.movie_id
GROUP BY r.movie_id, m.title
HAVING RatingAVG > 4
ORDER BY RatingAVG DESC


---**********---
--HARD MODE

-- Use concat and research about internet movie database to produce a valid url from the imdbid

-- Use concat and research about the movie database to produce a valid url from tmdbid

-- Get the ratings for The Unusuals and convert the timestamp into a human readable date time

-- Using SQL normalize the tags in the tags table. Make them lowercased and replace the spaces with -

-- Create a new field on the movies table for the year. Using an update query and a substring method update that column for every movie with the year found in the title column.

-- Once you have completed the new year column go through the title column and strip out the year.

-- Create a new column in the movies table and store the average review for each and every movie.