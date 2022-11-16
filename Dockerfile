FROM rust:1.63.0-alpine AS builtin-actors

# Install dependencies
RUN apt-get update && apt-get install --no-install-recommends -y build-essential clang

WORKDIR /usr/src/builtin-actors

RUN rustup target add wasm32-unknown-unknown

ENTRYPOINT ["/bin/bash", "-c"]
