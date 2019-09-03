-- JOINS

SELECT * FROM invoice
JOIN invoice_line
on invoice.invoice_id = invoice_line.invoice_id
WHERE invoice_line.unit_price > 0.99;


SELECT invoice_date, total, first_name, last_name
FROM invoice AS i
JOIN customer AS c
ON i.customer_id = c.customer_id;


SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM employee AS e
JOIN customer AS c
ON c.support_rep_id = e.employee_id;


SELECT title, name
FROM artist
JOIN album
ON album.artist_id = artist.artist_id;


SELECT track_id FROM playlist_track
JOIN playlist
ON playlist.playlist_id = playlist_track.playlist_id
WHERE playlist.name = 'Music';


SELECT t.name FROM track AS T
JOIN playlist_track AS p
ON t.track_id = p.track_id
WHERE p.playlist_id = 5;


SELECT t.name FROM track AS T
JOIN playlist_track AS p
ON t.track_id = p.track_id;


SELECT t.name, a.title FROM track AS t
JOIN album as a
ON t.album_id = a.album_id
JOIN genre as g
ON t.genre_id = g.genre_id
WHERE g.name = 'Alternative & Punk';



-- NESTED QUERIES
SELECT * FROM invoice
WHERE invoice_id IN (
  SELECT invoice_id from invoice_line
  WHERE unit_price > 0.99
);


SELECT * FROM playlist_track
WHERE playlist_id IN (
  SELECT playlist_id from playlist
  WHERE name = 'Music'
);


SELECT name FROM track
WHERE track_id IN (
  SELECT track_id from playlist_track
  WHERE playlist_id = 5
);


SELECT * FROM track
WHERE genre_id IN (
  SELECT genre_id from genre
  WHERE name = 'Comedy'
);


SELECT * FROM track
WHERE album_id IN (
  SELECT album_id from album
  WHERE name = 'Fireball'
);


SELECT * FROM track
WHERE album_id IN (
  SELECT album_id FROM album
  WHERE artist_id IN (
    SELECT artist_id from artist
    WHERE name = 'Queen'
  )
);



-- UPDATING ROWS
UPDATE customer
SET fax = null;


UPDATE customer
SET company = 'Self'
WHERE company IS null;


UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';


UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';


UPDATE track
set composer = 'The darkness around us'
WHERE genre_id IN (
  SELECT genre_id from genre
  WHERE name = 'Metal'
) AND composer IS null;



-- GROUP BY
SELECT count(track.genre_id), genre.name FROM track
JOIN genre
ON track.genre_id = genre.genre_id
GROUP BY genre.name;


SELECT count(track.genre_id), genre.name FROM track
JOIN genre
ON track.genre_id = genre.genre_id
WHERE genre.name = 'Pop' OR genre.name = 'Rock'
GROUP BY genre.name;


SELECT count(*), artist.name FROM album
JOIN artist
ON artist.artist_id = album.artist_id
GROUP BY artist.name;



-- DISTINCT
SELECT DISTINCT composer FROM track;


SELECT DISTINCT billing_postal_code FROM invoice;


SELECT DISTINCT billing_postal_code FROM invoice;



-- DELETE ROWS
DELETE FROM practice_delete
WHERE type='bronze';


DELETE FROM practice_delete
WHERE type='silver';


DELETE FROM practice_delete
WHERE value=150;



-- eCommerce Simulation
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20),
  email VARCHAR(40)
);


CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20),
  price INTEGER
);


CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  product_id INTEGER REFERENCES products(id)
);


INSERT INTO users
(name, email)
VALUES
('tayte', 'tayte@email.com'),
('matt', 'matt@email.com'),
('catie', 'catie@email.com');


INSERT INTO products
(name, price)
VALUES
('burger', 8),
('fries', 2),
('shake', 4);


INSERT INTO orders
(product_id)
VALUES
(3), (2), (1);


SELECT * FROM products
WHERE products.id IN (
  SELECT product_id FROM orders
  LIMIT 1
);


SELECT * FROM orders;


SELECT price FROM products
WHERE products.id IN (
  SELECT product_id FROM orders
  LIMIT 1
)


ALTER TABLE orders
ADD COLUMN 
user_id INTEGER REFERENCES users(id);


SELECT * FROM orders
WHERE user_id IN (
  SELECT id FROM users
  WHERE name = 'matt'
);

SELECT count(*) FROM orders
WHERE user_id IN (
  SELECT id FROM users
  WHERE name = 'matt'
);