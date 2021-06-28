import axios from "axios";

export const notifyGithub = (req: any, res: any) => {
  const r = req.body;
  const sha = r.sha;
  const repo = r.repo;
  const owner = r.owner || "jgunnink";
  const url = `https://api.github.com/repos/${owner}/${repo}/statuses/${sha}`;

  const data = JSON.stringify({
    state: r.state,
    context: r.context,
    description: r.description,
    // target_url: target_url, Used when providing a link to the output.
  });

  const config = {
    headers: {
      Accept: "application/vnd.github.v3+json",
      Authorization: `token ${process.env.GITHUB_TOKEN}`,
      "Content-Type": "application/json",
      "Content-Length": data.length,
      "User-Agent": "jgunnink-workflow-bot",
    },
  };

  axios
    .post(url, data, config)
    .then(res => {
      console.log(`statusCode: ${res.status}`);
    })
    .catch(error => {
      console.error(error);
    });

  res.send("Notified Github: Pipeline Running");
};
