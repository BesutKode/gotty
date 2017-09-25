FROM golang:1.9
MAINTAINER steven.rachman@gmail.com

RUN curl -sL https://deb.nodesource.com/setup_8.x \
  | bash - \
  && apt-get install --no-install-recommends -y nodejs=8.5.0-1nodesource1

RUN go get github.com/jteeuwen/go-bindata/... \
  && go get github.com/tools/godep

WORKDIR /go/src/github.com/yudai/gotty
COPY . ./
RUN make

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV PATH $PATH:/usr/games
RUN apt-get install --no-install-recommends -y cmatrix=1.2a-5+b2 sl=3.03-17+b2
ARG comd_var
ENV comd $comd_var

EXPOSE 8080
CMD ./gotty $comd
