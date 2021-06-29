"use strict";
exports.__esModule = true;
exports.notifyGithub = void 0;
var axios_1 = require("axios");
var notifyGithub = function (req, res) {
    var r = req.body;
    var sha = r.sha;
    var repo = r.repo;
    var owner = r.owner || "jgunnink";
    var url = "https://api.github.com/repos/" + owner + "/" + repo + "/statuses/" + sha;
    var data = JSON.stringify({
        state: r.state,
        context: r.context,
        description: r.description,
        workflowId: r.workflowId
    });
    var config = {
        headers: {
            Accept: "application/vnd.github.v3+json",
            Authorization: "token " + process.env.GITHUB_TOKEN,
            "Content-Type": "application/json",
            "Content-Length": data.length,
            "User-Agent": "jgunnink-workflow-bot"
        }
    };
    axios_1["default"]
        .post(url, data, config)
        .then(function (res) {
        console.log("statusCode: " + res.status);
    })["catch"](function (error) {
        console.error(error);
    });
    res.send("Notified Github: Pipeline Running");
};
exports.notifyGithub = notifyGithub;
