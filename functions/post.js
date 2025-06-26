export async function onRequest({ request, env }) {
  const { method } = request;
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json',
    'Access-Control-Allow-Methods': 'GET,POST,OPTIONS'
  };

  // CORS Preflight
  if (method === 'OPTIONS') {
    return new Response(null, { headers });
  }

  try {
    // Create Post
    if (method === 'POST') {
      const { text, username = "Anonymous" } = await request.json();
      
      const { success, meta } = await env.DB.prepare(
        `INSERT INTO posts (username, content) 
         VALUES (?, ?)`
      ).bind(username, text).run();

      if (!success) throw new Error('Database insert failed');

      const newPost = await env.DB.prepare(
        `SELECT * FROM posts WHERE id = ?`
      ).bind(meta.last_row_id).first();

      return Response.json(newPost, { status: 201, headers });
    }

    // Get Posts
    if (method === 'GET') {
      const { results } = await env.DB.prepare(
        `SELECT p.*, 
                COALESCE(pr.avatar, 'https://i.imgur.com/placeholder.jpg') as avatar
         FROM posts p
         LEFT JOIN profiles pr ON p.username = pr.username
         ORDER BY p.created_at DESC
         LIMIT 50`
      ).all();

      return Response.json(results, { headers });
    }

    return Response.json(
      { error: 'Method not allowed' },
      { status: 405, headers }
    );

  } catch (error) {
    return Response.json(
      { error: error.message },
      { status: 500, headers }
    );
  }
}
