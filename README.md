# Cdp Workflows

Common workflows for GitHub Actions.

- [Node.js](#nodejs)
  - [Check Pull Request](#check-pull-request)
  - [Publish](#publish)
    - [Job inputs](#job-inputs)

## Node.js

### Check Pull Request

The [Check Pull Request](.github/workflows/node-check-pull-request.yml) workflow runs code formatting checks, 
linting tests and unit tests on a Pull Request.

### Publish

The [Publish](.github/workflows/node-publish.yml) workflow runs will build, auto version and publish the application 
to its docker container registry.

#### Job Inputs

| Name        | Type   | Description                    |
|:------------|:-------|:-------------------------------|
| `imageName` | String | The services docker image name |
