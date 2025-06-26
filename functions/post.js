// Updated /functions/post.js
export async function onRequest(context) {
  const { request } = context;
  const { method } = request;

  // Mock database (resets on redeploy)
  let mockPosts = [
    { id: 1, user: "Tekuneintaake", text: "Hello MAURInet! 🌴", likes: 0 }
  ];

  // Handle POST (add new post)
  if (method === "POST") {
    const { user, text } = await request.json();
    const newPost = { id: mockPosts.length + 1, user, text, likes: 0 };
    mockPosts.push(newPost);
    return Response.json(newPost, { status: 201 });
  }

  // Handle GET (fetch posts)
  if (method === "GET") {
    return Response.json(mockPosts);
  }

  return Response.json({ error: "Method not allowed" }, { status: 405 });
}
// /functions/profile.js
export async function onRequest(context) {
  const { request, env } = context;
  const url = new URL(request.url);
  const username = url.pathname.split('/')[2]; // Extract /profile/:username

  // Fetch profile from D1
  if (request.method === "GET") {
    const { results } = await env.DB.prepare(
      "SELECT * FROM profiles WHERE username = ?"
    ).bind(username).all();
    return Response.json(results);
  }

  // Create/update profile (POST/PUT)
  if (request.method === "POST") {
    const { bio, avatar } = await request.json();
    await env.DB.prepare(
      "INSERT INTO profiles (username, bio, avatar) VALUES (?, ?, ?)"
    ).bind(username, bio, avatar).run();
    return Response.json({ success: true });
  }
}
