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
