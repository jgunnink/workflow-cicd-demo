import { expect } from "chai";
import { notifyGithub, R } from "../src/index";
import MockAdapter from "axios-mock-adapter";
import axios from "axios";

const failRequest: R = {
  body: {
    sha: "abc",
    repo: "repo",
    owner: "owner",
    state: "failure",
    description: "original",
    context: "context",
    workflowId: "abce12-ab15",
  },
};

const successRequest: R = {
  body: {
    sha: "abc",
    repo: "repo",
    owner: "owner",
    state: "success",
    description: "original",
    context: "context",
    workflowId: "abce12-ab15",
  },
};

describe("when there's an error", () => {
  const mock = new MockAdapter(axios);
  mock
    .onPost(
      `https://api.github.com/repos/${failRequest.body.owner}/${failRequest.body.repo}/statuses/${failRequest.body.sha}`,
    )
    .reply(201);
  const failedResult = notifyGithub(failRequest, { send: () => null });

  it("transforms the status to prepend with 'Failed -'", () => {
    expect(JSON.parse(failedResult).description).to.equal("Failed - original");
  });
  mock.restore();
});

describe("when there no error", () => {
  const mock = new MockAdapter(axios);
  mock
    .onPost(
      `https://api.github.com/repos/${successRequest.body.owner}/${successRequest.body.repo}/statuses/${successRequest.body.sha}`,
    )
    .reply(201);
  const successResult = notifyGithub(successRequest, { send: () => null });

  it("doesn't transform the status", () => {
    expect(JSON.parse(successResult).description).to.equal("original");
  });
  mock.restore();
});
