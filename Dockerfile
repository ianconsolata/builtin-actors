FROM rust:1.63.0-alpine AS builtin-actors

WORKDIR /usr/src/builtin-actors

RUN rustup target add wasm32-unknown-unknown

ENTRYPOINT ["/bin/bash", "-c"]
