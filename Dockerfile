FROM codercom/code-server:3.9.3

USER root
RUN apt-get update \
  && apt-get install -y \
  netcat \
  && rm -rf /var/lib/apt/lists/*

# Install go
ENV GO_VERSION=1.16.3
RUN curl -LO "https://golang.org/dl/go${GO_VERSION}.linux-arm64.tar.gz" \
  && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-arm64.tar.gz \
  && echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile

# Install Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
  && chmod 700 get_helm.sh \
  && ./get_helm.sh

# Install Hugo
ENV HUGO_VERSION=8.82.0
RUN curl -LO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-ARM64.tar.gz" \
  && sudo tar -C /usr/local -xzf hugo_${HUGO_VERSION}_Linux-ARM64.tar.gz

USER 1000
ENV USER=coder

WORKDIR /home/coder
