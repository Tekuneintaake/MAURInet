// Simple API for MAURInet (Cloudflare Pages Function)
export async function onRequest(context) {
  const { request } = context;
  const { method } = request;

  // Temporary "database" (just an array)
  let posts = [
    { id: 1, user: "Tekuneintaake", text: "Hello MAURInet! 🌴", likes: 0 },
    { id: 2, user: "Friend", text: "Nice weather today! ☀️", likes: 0 },
  ];

  // GET: Fetch all posts (like a Facebook feed)
  if (method === "GET") {
    return Response.json(posts);
  }

  // POST: Add a new post (like a status update)
  if (method === "POST") {
    const { user, text } = await request.json();
    const newPost = { id: posts.length + 1, user, text, likes: 0 };
    posts.push(newPost);
    return Response.json(newPost, { status: 201 });
  }

  // Ignore other methods (PUT/DELETE for now)
  return Response.json({ error: "Not supported" }, { status: 404 });
}
