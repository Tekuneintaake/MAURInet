// Cloudflare Pages Function (similar to Facebook's API endpoints)
export async function onRequest(context) {
  const { request } = context;
  const { method } = request;

  // Mock database (replace with a real DB like D1, KV, or Supabase)
  let mockPosts = [
    { id: 1, user: "Tekuneintaake", text: "Hello MAURInet! 🌴", likes: 0 },
    { id: 2, user: "Friend", text: "Nice weather today! ☀️", likes: 0 },
  ];

  // Handle GET (fetch posts)
  if (method === "GET") {
    return new Response(JSON.stringify(mockPosts), {
      headers: { "Content-Type": "application/json" },
    });
  }

  // Handle POST (add a new post)
  if (method === "POST") {
    const data = await request.json();
    const newPost = {
      id: mockPosts.length + 1,
      user: data.user || "Anonymous",
      text: data.text,
      likes: 0,
    };
    mockPosts.push(newPost);
    return new Response(JSON.stringify(newPost), { status: 201 });
  }

  // Handle other methods (PUT for likes, DELETE, etc.)
  return new Response("Not implemented", { status: 501 });
}
