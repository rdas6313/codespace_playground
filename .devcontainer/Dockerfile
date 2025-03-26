# Use an Ubuntu base image
FROM ubuntu:22.04

# Install required dependencies
RUN apt update && apt install -y \
    gcc-arm-none-eabi \
    binutils-arm-none-eabi \
    gdb-multiarch \
    make \
    cmake \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set default working directory
WORKDIR /workspace

CMD ["/bin/bash"]
