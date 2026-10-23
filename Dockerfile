FROM --platform=linux/amd64 debian:latest
ENV DEBIAN_FRONTEND=noninteractive

ARG BW_VERSION=2026.6.1

WORKDIR /usr/local/bin
RUN apt update && apt install -y curl unzip libsecret-1-0 jq
COPY entrypoint.sh .
RUN curl -fsSL -o bw.zip "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip" \
  && unzip bw.zip && rm bw.zip && chmod +x ./bw
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
