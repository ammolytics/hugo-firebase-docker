FROM ammolytics/firebase-docker:latest


ENV HUGO_VERSION 0.74.3
ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz
ENV HUGO_URL https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}


RUN apk add --no-cache \
  wget \
  ca-certificates


RUN wget -q "$HUGO_URL" \
  && tar xzf ${HUGO_BINARY} \
  && mv hugo /usr/bin \
  && rm LICENSE README.md ${HUGO_BINARY} \
  && apk del wget ca-certificates \
  && hugo check \
  && hugo env
