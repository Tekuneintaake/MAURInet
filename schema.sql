
-- User profiles
CREATE TABLE IF NOT EXISTS profiles (
  username TEXT PRIMARY KEY,
  bio TEXT,
  avatar TEXT DEFAULT 'https://i.imgur.com/placeholder.jpg',
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Social posts (updated to support image_url)
CREATE TABLE IF NOT EXISTS posts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL,
  content TEXT,
  image_url TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (username) REFERENCES profiles(username)
);

-- Reactions (Facebook-like)
CREATE TABLE IF NOT EXISTS reactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL,
  post_id INTEGER NOT NULL,
  reaction_type TEXT NOT NULL,  -- 'like', 'love', 'haha', etc.
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (username) REFERENCES profiles(username),
  FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- Comments with nested replies
CREATE TABLE IF NOT EXISTS comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  post_id INTEGER NOT NULL,
  username TEXT NOT NULL,
  content TEXT NOT NULL,
  parent_comment_id INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (username) REFERENCES profiles(username),
  FOREIGN KEY (post_id) REFERENCES posts(id),
  FOREIGN KEY (parent_comment_id) REFERENCES comments(id)
);

-- Friendships (for follow/friend requests)
CREATE TABLE IF NOT EXISTS friendships (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  requester TEXT NOT NULL,
  addressee TEXT NOT NULL,
  status TEXT NOT NULL,  -- 'pending', 'accepted', 'declined'
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (requester) REFERENCES profiles(username),
  FOREIGN KEY (addressee) REFERENCES profiles(username)
);

-- Messages (private chat)
CREATE TABLE IF NOT EXISTS messages (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  sender TEXT NOT NULL,
  receiver TEXT NOT NULL,
  content TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  read INTEGER DEFAULT 0,
  FOREIGN KEY (sender) REFERENCES profiles(username),
  FOREIGN KEY (receiver) REFERENCES profiles(username)
);

-- Notifications
CREATE TABLE IF NOT EXISTS notifications (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL,
  type TEXT NOT NULL,  -- 'like', 'comment', etc.
  reference_id INTEGER,
  is_read INTEGER DEFAULT 0,
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

-- Product listings
CREATE TABLE IF NOT EXISTS products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  store_id INTEGER,
  name TEXT,
  description TEXT,
  image_url TEXT,
  price REAL,
  location TEXT,
  is_available INTEGER DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (store_id) REFERENCES stores(id)
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_posts_username ON posts(username);
CREATE INDEX IF NOT EXISTS idx_posts_created ON posts(created_at);
CREATE INDEX IF NOT EXISTS idx_stores_username ON stores(username);
CREATE INDEX IF NOT EXISTS idx_products_store ON products(store_id);
CREATE INDEX IF NOT EXISTS idx_products_location ON products(location);
