FROM codercom/code-server:3.8.1

USER root
RUN apt-get update \
  && apt-get install -y \
  netcat \
  && rm -rf /var/lib/apt/lists/*

# Install go
RUN curl -LO "https://golang.org/dl/go1.15.8.linux-arm64.tar.gz" \
  && sudo tar -C /usr/local -xzf go1.15.8.linux-arm64.tar.gz \
  && echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile

# Install Kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
  && chmod 700 get_helm.sh \
  && ./get_helm.sh

USER 1000
ENV USER=coder

WORKDIR /home/coder
