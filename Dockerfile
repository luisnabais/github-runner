FROM debian:12.5

ENV RUNNER_VERSION=2.316.1
ENV DEBIAN_FRONTEND=noninteractive
ENV ARCH=arm64
ENV DEFAULT_USER=github

LABEL BaseImage="debian:12.5"
LABEL RunnerVersion=${RUNNER_VERSION}

# Update base packages & add a non root/sudo user
RUN apt-get update -y && apt-get upgrade -y && useradd -m ${DEFAULT_USER}

# Packages
RUN apt-get install -y --no-install-recommends \
    curl nodejs wget unzip vim git jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

# GitHub Actions Runner
RUN cd /home/${DEFAULT_USER} && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz

# GitHub Actions Runner additional dependencies
RUN chown -R ${DEFAULT_USER}:${DEFAULT_USER} ~${DEFAULT_USER} && /home/${DEFAULT_USER}/actions-runner/bin/installdependencies.sh

# Start script
ADD files/start.sh start.sh
RUN chmod +x start.sh

USER ${DEFAULT_USER}
ENTRYPOINT ["./start.sh"]
