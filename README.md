# github-runner

## Running instructions
### Manually
To run this github-runner using Docker, you need Docker installed and then just execute the command
```
docker run -tdi --name github-token \
-e GH_TOKEN="${GH_TOKEN}" \
-e GH_OWNER="${GH_OWNER}" \
-e GH_REPOSITORY='${GH_REPOSITORY}" \
-e RUNNER_NAME="${RUNNER_NAME}"
```

### Docker-Compose
Create the docker-compose.yml file:
```
---
version: '3.8'
services:
  runner:
    image: ghcr.io/luisnabais/github-runner:latest
    environment:
      GH_TOKEN: ${GH_TOKEN}
      GH_OWNER: ${GH_OWNER}
      GH_REPOSITORY: ${GH_REPOSITORY}
      RUNNER_NAME: ${RUNNER_NAME}
```

and execute the command
```
docker-compose up -d
```

### Variables:
- GH_TOKEN: Token you can get on your GitHub Repository/Organization/Enterprise, when configuring the new runner
- GH_OWNER: GitHub account name, as in the URL. It's the username, or the organization. Usually the part before the repository name in the URL. It's 'luisnabais' in this repository.
- GH_REPOSITORY: GitHub repository, as in the URL. In this case is github-runner.
- RUNNER_NAME: Name of the runner, visible in GitHub Actions configuration.
