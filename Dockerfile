FROM rust:1-buster AS builtin-actors

# Install dependencies
RUN apt-get update && apt-get install --no-install-recommends -y build-essential clang

WORKDIR /usr/src/builtin-actors

ENTRYPOINT ["/bin/bash", "-c"]
