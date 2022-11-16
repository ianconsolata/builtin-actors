FROM rust:1.63.0-alpine AS builtin-actors

# Install dependencies
RUN apk update && apk add -y alpine-sdk clang

WORKDIR /usr/src/builtin-actors

RUN rustup target add wasm32-unknown-unknown

ENTRYPOINT ["/bin/bash", "-c"]
