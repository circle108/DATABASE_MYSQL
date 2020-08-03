
-- Task 2

CREATE TABLE likes (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL,
	target_id INT UNSIGNED NOT NULL,
	target_type_id INT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW()
);

CREATE TABLE target_types (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE,
	created_at DATETIME DEFAULT NOW()
);

INSERT INTO 
	target_types (name) 
VALUES 
	('messages'),
	('users'),
	('media'),
	('posts');

INSERT INTO
	likes 
SELECT
	id,
	FLOOR(1 + (RAND() * 100)),
	FLOOR(1 + (RAND() * 100)),
	FLOOR(1 + (RAND() * 4)),
	NOW() FROM messages;

SELECT * FROM likes LIMIT 10;
	
CREATE TABLE posts (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL,
	community_id INT UNSIGNED,
	head VARCHAR(255),
	body TEXT NOT NULL,
	media_id INT UNSIGNED,
	is_public BOOLEAN DEFAULT TRUE,
	is_archived BOOLEAN DEFAULT FALSE,
	views_counter INT UNSIGNED DEFAULT 0,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

-- Task 1
	
ALTER TABLE posts 
	ADD CONSTRAINT posts_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id),
	ADD CONSTRAINT posts_media_id_fk
		FOREIGN KEY (media_id) REFERENCES media(id);
		
ALTER TABLE profiles 
	ADD CONSTRAINT profiles_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT profiles_photo_id_fk
		FOREIGN KEY (photo_id) REFERENCES media(id)
			ON DELETE SET NULL;

ALTER TABLE messages 
	ADD CONSTRAINT messages_from_user_id_fk 
		FOREIGN KEY (from_user_id) REFERENCES users(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT messages_to_user_id_fk 
		FOREIGN KEY (to_user_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
DESC communities_users ;
ALTER TABLE communities_users 
	ADD CONSTRAINT communities_users_community_id_fk
		FOREIGN KEY (community_id) REFERENCES communities(id);
ALTER TABLE communities_users 
	ADD CONSTRAINT communities_users_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id);
	
DESC media;
ALTER TABLE media 
	ADD CONSTRAINT media_media_type_id_fk
		FOREIGN KEY (media_type_id) REFERENCES media_types(id)
			ON DELETE CASCADE,
	ADD CONSTRAINT media_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
DESC friendship;

ALTER TABLE friendship 
	ADD CONSTRAINT friendship_friend_id_fk
		FOREIGN KEY (friend_id) REFERENCES users(id),	
	ADD CONSTRAINT friendship_status_id_fk
		FOREIGN KEY (status_id) REFERENCES friendship_statutes(id),
	ADD CONSTRAINT friendship_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id);

DESC likes;
ALTER TABLE likes 
	ADD CONSTRAINT likes_user_id
		FOREIGN KEY (user_id) REFERENCES users(id),
	ADD CONSTRAINT likes_target_id
		FOREIGN KEY (target_id) REFERENCES users(id),
	ADD CONSTRAINT likes_target_type_id
		FOREIGN KEY (target_type_id) REFERENCES target_types(id);

-- Task 3

SELECT 
	gender,
	(SELECT target_id FROM likes WHERE likes.id = user_id) AS target,
	COUNT(*) AS total
FROM 
	profiles
GROUP BY gender;



		
		