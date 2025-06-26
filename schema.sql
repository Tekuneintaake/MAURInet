-- Initialize tables
CREATE TABLE IF NOT EXISTS profiles (
  username TEXT PRIMARY KEY,
  bio TEXT,
  avatar TEXT DEFAULT 'https://i.imgur.com/placeholder.jpg',
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT,
  content TEXT,
  likes INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (username) REFERENCES profiles(username)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_posts_username ON posts(username);
CREATE INDEX IF NOT EXISTS idx_posts_created ON posts(created_at);
