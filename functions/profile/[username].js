export async function onRequest({ request, env, params }) {
  const { method } = request;
  const { username } = params;
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json'
  };

  try {
    // Update Profile
    if (method === 'POST') {
      const { bio, avatar } = await request.json();
      
      await env.DB.prepare(
        `INSERT INTO profiles (username, bio, avatar)
         VALUES (?, ?, ?)
         ON CONFLICT(username) 
         DO UPDATE SET bio=excluded.bio, avatar=excluded.avatar`
      ).bind(username, bio, avatar).run();

      const profile = await env.DB.prepare(
        `SELECT * FROM profiles WHERE username = ?`
      ).bind(username).first();

      return Response.json(profile, { headers });
    }

    // Get Profile
    if (method === 'GET') {
      const profile = await env.DB.prepare(
        `SELECT *, 
                (SELECT COUNT(*) FROM posts WHERE username = ?) as post_count
         FROM profiles 
         WHERE username = ?`
      ).bind(username, username).first();

      return profile
        ? Response.json(profile, { headers })
        : Response.json({ error: 'Profile not found' }, { status: 404, headers });
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
