FROM golang:1.9

RUN curl -sL https://deb.nodesource.com/setup_8.x \
  | bash - \
  && apt-get install -y npm

RUN go get github.com/jteeuwen/go-bindata/... \
  && go get github.com/tools/godep

WORKDIR /go/src/github.com/yudai/gotty
ADD . ./
RUN make

EXPOSE 8080
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV PATH $PATH:/usr/games
RUN apt-get install -y cmatrix sl
CMD ["./gotty", "cmatrix"]
