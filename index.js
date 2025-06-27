const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Connect to SQLite DB
const db = new sqlite3.Database('./maurinet.db', (err) => {
  if (err) return console.error(err.message);
  console.log('🗃️ Connected to SQLite database.');
});

// Sample Route: Home
app.get('/', (req, res) => {
  res.send('MAURInet backend is running 🚀');
});

// Create a post
app.post('/posts', (req, res) => {
  const { username, content } = req.body;
  const createdAt = new Date().toISOString();
  db.run(
    'INSERT INTO posts (username, content, created_at) VALUES (?, ?, ?)',
    [username, content, createdAt],
    function (err) {
      if (err) return res.status(500).json({ error: err.message });
      res.status(201).json({ id: this.lastID, username, content });
    }
  );
});

// Get all posts
app.get('/posts', (req, res) => {
  db.all('SELECT * FROM posts ORDER BY created_at DESC', [], (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Create a comment
app.post('/comments', (req, res) => {
  const { post_id, user_id, content } = req.body;
  const createdAt = new Date().toISOString();
  db.run(
    'INSERT INTO comments (post_id, user_id, content, created_at) VALUES (?, ?, ?, ?)',
    [post_id, user_id, content, createdAt],
    function (err) {
      if (err) return res.status(500).json({ error: err.message });
      res.status(201).json({ id: this.lastID, post_id, user_id, content });
    }
  );
});

// Get comments for a post
app.get('/comments/:postId', (req, res) => {
  const { postId } = req.params;
  db.all('SELECT * FROM comments WHERE post_id = ?', [postId], (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 Server is running on http://localhost:${PORT}`);
});
