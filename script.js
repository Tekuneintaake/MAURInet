function postMessage() {
  const textarea = document.querySelector("textarea");
  const feed = document.getElementById("feed");

  if (textarea.value.trim() === "") return;

  const newPost = document.createElement("div");
  newPost.className = "post";
  newPost.innerHTML = `
    <p><strong>@you</strong>: ${textarea.value}</p>
    <span class="time">Just now</span>
  `;
  feed.prepend(newPost);
  textarea.value = "";
}
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
