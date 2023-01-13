-- benchmarker/userdata/load.rbから読み込まれる

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `account_name` varchar(64) NOT NULL UNIQUE,
  `passhash` varchar(128) NOT NULL, -- SHA2 512 non-binary (hex)
  `authority` tinyint(1) NOT NULL DEFAULT 0,
  `del_flg` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY pr_users (`id` DESC)
) DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `mime` varchar(64) NOT NULL,
  `imgdata` mediumblob NOT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY pr_posts (`id` DESC)
) DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY pr_comments (`id` DESC)
) DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_post_id ON comments(post_id);
CREATE INDEX idx_user_id ON comments(user_id);
CREATE INDEX idx_created_post ON posts(created_at);