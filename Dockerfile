FROM debian


RUN apt-get update && apt-get install -y \
    build-essential autoconf libtool pkg-config libssl-dev \
    git curl make cmake g++ \
    && apt-get clean

RUN git clone --recurse-submodules -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc && \
    cd grpc && \
    mkdir -p cmake/build && cd cmake/build && cmake -DCMAKE_BUILD_TYPE=Release -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DCMAKE_CXX_FLAGS=-latomic ../.. && make -j$(nproc) && make install && make clean && ldconfig && \
    rm -rf /grpc
