export async function onRequest(context) {
  const { request } = context;
  const { method } = request;

  // Mock database (resets on redeploy)
  let mockPosts = [
    { id: 1, user: "Anonymous", text: "Welcome to MAURInet! 🌴", likes: 0 }
  ];

  // Set CORS headers
  const headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET,POST,OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type'
  };

  // Handle OPTIONS for CORS preflight
  if (method === 'OPTIONS') {
    return new Response(null, { headers });
  }

  try {
    // Handle POST (add new post)
    if (method === "POST") {
      const { text, user = "Anonymous" } = await request.json();
      const newPost = { 
        id: mockPosts.length + 1, 
        user,
        text, 
        likes: 0,
        timestamp: new Date().toISOString()
      };
      mockPosts.push(newPost);
      return Response.json(newPost, { status: 201, headers });
    }

    // Handle GET (fetch posts)
    if (method === "GET") {
      return Response.json(mockPosts, { headers });
    }

    return Response.json(
      { error: "Method not allowed" }, 
      { status: 405, headers }
    );

  } catch (error) {
    return Response.json(
      { error: "Internal server error" },
      { status: 500, headers }
    );
  }
}
