FROM debian

RUN apt-get update && apt-get install -y \
    build-essential autoconf git pkg-config libssl-dev \
    automake wget libtool curl make cmake g++ unzip \
    && apt-get clean

ENV GOVERSION 1.14
ENV GOOS linux
ENV GOARCH amd64

RUN wget https://dl.google.com/go/go$GOVERSION.$GOOS-$GOARCH.tar.gz && \
    tar -C /usr/local -xzf go$GOVERSION.$GOOS-$GOARCH.tar.gz && \
    rm -rf /go$GOVERSION.$GOOS-$GOARCH.tar.gz

RUN export PATH=$PATH:/usr/local/go/bin && \
    git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc && \
    cd grpc && \
    git submodule update --init && \
    mkdir -p cmake/build && cd cmake/build && cmake ../.. && make -j$(nproc) && make install && make clean && ldconfig && \
    rm -rf /grpc
