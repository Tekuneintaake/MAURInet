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
