// Save new posts
export async function onRequestPost({ env, request }) {
  const { content } = await request.json();
  await env.DB.prepare(
    "INSERT INTO posts (content) VALUES (?)"
  ).bind(content).run();
  return new Response("Post saved!");
}

// Fetch all posts
export async function onRequestGet({ env }) {
  const { results } = await env.DB.prepare(
    "SELECT * FROM posts ORDER BY timestamp DESC"
  ).all();
  return Response.json(results);
}
