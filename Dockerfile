FROM alpine

RUN apk add --no-cache bash perl

ADD entrypoint /entrypoint

ENTRYPOINT [ "/entrypoint" ]
