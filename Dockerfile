ARG RUST_VERSION=1.67

FROM rust:${RUST_VERSION}-buster

    ARG TRUNK_VERSION=^0.16.0
    ARG USER_UID=1000
    ARG GROUP_ID=1000

    ENV TRUNK_VERSION=${TRUNK_VERSION}
    ENV USER_USER_UID=${USER_UID}
    ENV GROUP_ID=${GROUP_ID}
    ENV PNPM_HOME="/home/builder/.local/share/pnpm"
    ENV PATH="$PNPM_HOME:$PATH"
    ENV PATH="/scripts:$PATH"
    ENV PNPM_PRE=true

    # Create 'builder' user and group
    RUN groupadd -g 1000 builder && \
        useradd -m -s /bin/bash -u ${USER_USER_UID} -g ${GROUP_ID} builder

    # Switch to builder user
    USER ${USER_UID}:${GROUP_ID}

    # Add wasm target
    RUN rustup target add wasm32-unknown-unknown

    # Install pnpm and node
    RUN wget -qO- https://get.pnpm.io/install.sh | SHELL=bash sh - && pnpm add -g node-linux-x64

    # Install trunk
    RUN cargo install --locked --version ${TRUNK_VERSION} trunk

    # Add build scripts
    USER root:root
    WORKDIR /scripts
    COPY scripts/ ./

    USER builder:builder
    WORKDIR /app

    CMD [ "bash", "run" ]
