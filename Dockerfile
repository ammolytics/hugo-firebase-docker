FROM ammolytics/firebase-docker:latest


ENV GLIBC_VERSION 2.31-r0
ENV HUGO_VERSION 0.74.3
ENV HUGO_BINARY hugo_extended_$(HUGO_VERSION)_Linux-64bit.tar.gz
ENV HUGO_URL https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/$(HUGO_BINARY)


RUN apk add --no-cache \
  wget \
  ca-certificates \
  libstdc++


RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" \
  && wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$(GLIBC_VERSION)/glibc-$(GLIBC_VERSION).apk" \
  && wget "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$(GLIBC_VERSION)/glibc-bin-$(GLIBC_VERSION).apk" \
  && apk add --no-cache "glibc-$(GLIBC_VERSION).apk" \
  && apk add --no-cache "glibc-bin-$(GLIBC_VERSION).apk" \
  && rm "glibc-$(GLIBC_VERSION).apk" \
  && rm "glibc-bin-$(GLIBC_VERSION).apk"


RUN wget $(HUGO_URL) \
  && tar xzf $(HUGO_BINARY) \
  && mv hugo /usr/bin && \
  && rm LICENSE README.md $(HUGO_BINARY) \
  && apk del wget ca-certificates && \
  && hugo version
