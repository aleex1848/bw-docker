FROM --platform=linux/amd64 debian:latest
ENV DEBIAN_FRONTEND=noninteractive

ARG BW_VERSION=2026.6.1

WORKDIR /usr/local/bin
RUN apt update && apt install -y curl unzip libsecret-1-0 jq
COPY entrypoint.sh .
# Ab 2026.11.0 heißt das Asset bw-bit-linux-*, davor bw-linux-*
RUN BASE="https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}" \
  && (curl -fsSL -o bw.zip "$BASE/bw-bit-linux-${BW_VERSION}.zip" \
      || curl -fsSL -o bw.zip "$BASE/bw-linux-${BW_VERSION}.zip") \
  && unzip bw.zip && rm bw.zip && chmod +x ./bw
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
