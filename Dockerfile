FROM alpine:3.7 as build

RUN set -x && \
    apk add --no-cache  \
    gcc \
    libc-dev \
    autoconf \
    automake \
    make \
    git

RUN set -x && \
    mkdir -p /tmp/build/ && \
    git clone https://github.com/mjeromin/ci-testing.git /tmp/build/ci-testing

RUN set -x && \
    cd /tmp/build/ci-testing/ && \
    \
    CC="gcc" \
    \
    ./configure && \
    make

FROM alpine:3.7

LABEL maintainer="Mark Jeromin <mark.jeromin@sysfrog.net>"

RUN set -x && \
    apk update

COPY --from=build /tmp/build/ci-testing/helloworld /bin/helloworld

RUN set -x && \
    chmod +x /bin/helloworld

CMD ["/bin/helloworld"]
