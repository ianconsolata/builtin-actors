FROM rust:1.63.0-alpine AS builtin-actors

# Install dependencies
RUN apk add --update-cache alpine-sdk clang bash

WORKDIR /usr/src/builtin-actors

RUN rustup target add wasm32-unknown-unknown

ENTRYPOINT ["/bin/bash", "-c"]
