function postMessage() {
  const textarea = document.querySelector("textarea");
  const feed = document.getElementById("feed");
  const content = textarea.value.trim();

  if (content === "") return;

  fetch("https://your-cloudflare-backend-url/posts", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      username: "you", // Replace with actual logged-in user later
      content: content
    })
  })
    .then(res => res.json())
    .then(data => {
      const newPost = document.createElement("div");
      newPost.className = "post";
      newPost.innerHTML = `
        <p><strong>@${data.username}</strong>: ${data.content}</p>
        <span class="time">Just now</span>
      `;
      feed.prepend(newPost);
      textarea.value = "";
    })
    .catch(err => console.error("Error posting:", err));
}
