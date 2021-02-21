FROM golang:1.16-buster

ARG platform=telegram

RUN apt-get update
RUN apt-get install -y \
        git            \
        gcc            \
        make           \
        cmake          \
        libgflags-dev  \
        libsnappy-dev  \
        zlib1g-dev     \
        libbz2-dev     \
        liblz4-dev     \
        libzstd-dev

RUN git clone https://github.com/facebook/rocksdb.git
WORKDIR rocksdb
RUN cmake .
RUN make
RUN make install
RUN rm -rf /go/rocksdb

WORKDIR /go
ENV ROCKSDB_SHARED=/usr/lib/librocksdb.a
ENV ROCKSDB_STATIC=/usr/include/rocksdb
