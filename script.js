export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);

    // GET all users
    if (url.pathname === '/api/users' && request.method === 'GET') {
      try {
        const { results } = await env.DB.prepare('SELECT * FROM users').all();
        return new Response(JSON.stringify(results), {
          headers: { 'Content-Type': 'application/json' },
          status: 200,
        });
      } catch (error) {
        return new Response(JSON.stringify({ error: error.message }), {
          headers: { 'Content-Type': 'application/json' },
          status: 500,
        });
      }
    }

    // 404 fallback
    return new Response('Not Found', { status: 404 });
  }
};
