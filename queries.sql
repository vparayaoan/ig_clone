-- Finding the 5 oldest users
SELECT *
FROM users
ORDER BY created_at 
LIMIT 5;

-- Finding the day of the week most users register on
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

-- Finding the users who have never posted a photo
SELECT username
FROM users
LEFT JOIN photos 
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Finding the person with the most liked photo
SELECT 
    username,
    photos.id,
    photos.image_url, 
COUNT(*) AS total
FROM photos
INNER JOIN likes 
    ON photos.id = likes.photo_id
INNER JOIN users 
    ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY total DESC LIMIT 1;

-- Finding the average amount of times a user posts
SELECT (SELECT COUNT(*) 
        FROM photos) / (SELECT COUNT(*) 
                        FROM users) AS avg; 

-- Finding the top five most commonly used hashtags
SELECT 
    tags.tag_name,
    COUNT(*) AS total
FROM tags
INNER JOIN photo_tags
    ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC LIMIT 5;

-- Finding Bots - users who have liked every single photo
SELECT
    username,
    COUNT(*) AS total_likes
FROM users
INNER JOIN likes
    ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING total_likes = (SELECT COUNT(*) FROM photos);



