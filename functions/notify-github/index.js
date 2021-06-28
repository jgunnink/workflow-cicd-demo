/**
 * Responds to any HTTP request.
 *
 * @param {!express:Request} req HTTP request context.
 * @param {!express:Response} res HTTP response context.
 */

const https = require("https");

exports.helloWorld = (req, res) => {
  const r = req.body;
  const sha = r.sha;
  const repo = r.repo;
  const owner = r.owner || "jgunnink";

  const data = JSON.stringify({
    state: r.state,
    context: r.context,
    description: r.description,
    // target_url: target_url, Used when providing a link to the output.
  });

  const options = {
    hostname: `api.github.com`,
    port: 443,
    path: `/repos/${owner}/${repo}/statuses/${sha}`,
    method: "POST",
    headers: {
      Accept: "application/vnd.github.v3+json",
      Authorization: `token ${GITHUB_TOKEN}`,
      "Content-Type": "application/json",
      "Content-Length": data.length,
    },
  };

  const subReq = https.request(options, res => {
    console.log(`response statusCode: ${res.statusCode}`);

    res.on("data", d => {
      console.log(`response data: ${d}`);
    });
  });

  subReq.on("error", error => {
    console.error(error);
  });

  subReq.write(data);
  subReq.end();
  res.status(200);
};
