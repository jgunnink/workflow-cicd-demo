import axios from "axios";

export interface R {
  body: {
    sha: string;
    repo: string;
    owner: string;
    description: string;
    state: "pending" | "success" | "failure";
    context: string;
    workflowId: string;
  };
}

export const notifyGithub = (req: R, res: any) => {
  const r = req.body;
  const sha = r.sha;
  const repo = r.repo;
  const owner = r.owner || "jgunnink";
  const url = `https://api.github.com/repos/${owner}/${repo}/statuses/${sha}`;

  if (r.state === "failure") {
    r.description = `Failed - ${r.description}`;
  }

  const data = JSON.stringify({
    state: r.state,
    context: r.context,
    description: r.description,
    target_url: `https://console.cloud.google.com/workflows/workflow/us-central1/workflow-1/execution/${r.workflowId}?project=${process.env.GCP_PROJECT}`,
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
      console.log(`Github reponded with: ${res.status}`);
    })
    .catch(error => {
      console.error(error);
    });

  res.send("Notified Github");
  return data;
};
