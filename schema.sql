-- User profiles
CREATE TABLE IF NOT EXISTS profiles (
  username TEXT PRIMARY KEY,
  bio TEXT,
  avatar TEXT DEFAULT 'https://i.imgur.com/placeholder.jpg',
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Social posts
CREATE TABLE IF NOT EXISTS posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT,
  content TEXT,
  likes INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (username) REFERENCES profiles(username)
);

-- Business store accounts
CREATE TABLE IF NOT EXISTS stores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT,
  store_name TEXT,
  description TEXT,
  logo TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  subscription_end DATE,
  FOREIGN KEY (username) REFERENCES profiles(username)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_posts_username ON posts(username);
CREATE INDEX IF NOT EXISTS idx_posts_created ON posts(created_at);
CREATE INDEX IF NOT EXISTS idx_stores_username ON stores(username);
-- User profiles
CREATE TABLE IF NOT EXISTS profiles (
  username TEXT PRIMARY KEY,
  bio TEXT,
  avatar TEXT DEFAULT 'https://i.imgur.com/placeholder.jpg',
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Social posts
CREATE TABLE IF NOT EXISTS posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT,
  content TEXT,
  likes INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (username) REFERENCES profiles(username)
);

-- Business store accounts
CREATE TABLE IF NOT EXISTS stores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT,
  store_name TEXT,
  description TEXT,
  logo TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  subscription_end DATE,
  FOREIGN KEY (username) REFERENCES profiles(username)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_posts_username ON posts(username);
CREATE INDEX IF NOT EXISTS idx_posts_created ON posts(created_at);
CREATE INDEX IF NOT EXISTS idx_stores_username ON stores(username);

-- Product listings
CREATE TABLE IF NOT EXISTS products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  store_id INTEGER,
  name TEXT,
  description TEXT,
  image_url TEXT,
  price REAL,
  location TEXT,
  is_available BOOLEAN DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (store_id) REFERENCES stores(id)
);

-- Product indexes
CREATE INDEX IF NOT EXISTS idx_products_store ON products(store_id);
CREATE INDEX IF NOT EXISTS idx_products_location ON products(location);
-- Posts table (with optional image URLs)
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  content TEXT,
  image_url TEXT,            -- optional photo URL
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Reactions table (like Facebook reactions)
CREATE TABLE reactions (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  post_id INTEGER NOT NULL REFERENCES posts(id),
  reaction_type VARCHAR(20) NOT NULL,  -- e.g. 'like', 'love', 'haha'
  created_at TIMESTAMP DEFAULT NOW()
);

-- Comments table (with parent_comment_id for replies)
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  post_id INTEGER NOT NULL REFERENCES posts(id),
  user_id INTEGER NOT NULL,
  content TEXT NOT NULL,
  parent_comment_id INTEGER REFERENCES comments(id),  -- for replies
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Friendships table
CREATE TABLE friendships (
  id SERIAL PRIMARY KEY,
  requester_id INTEGER NOT NULL,
  addressee_id INTEGER NOT NULL,
  status VARCHAR(20) NOT NULL,   -- 'pending', 'accepted', 'declined'
  created_at TIMESTAMP DEFAULT NOW()
);

-- Messages table
CREATE TABLE messages (
  id SERIAL PRIMARY KEY,
  sender_id INTEGER NOT NULL,
  receiver_id INTEGER NOT NULL,
  content TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT NOW(),
  read BOOLEAN DEFAULT FALSE
);

-- Notifications table
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,       -- user to notify
  type VARCHAR(50) NOT NULL,      -- 'like', 'comment', 'friend_request', 'message'
  reference_id INTEGER,            -- id of post, comment, friend request, message, etc.
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW()
);
