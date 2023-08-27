FROM golang:1.17.13-alpine AS build

# 增加国内镜像源
ENV GOPROXY=https://goproxy.io,https://mirrors.aliyun.com/goproxy/,direct

# 複製原始碼
COPY . /go/src/test
WORKDIR /go/src/test

# 進行編譯(名稱為：project)
RUN go build -o test

# 最終運行golang 的基底
FROM alpine

COPY --from=build /go/src/test /app/bin/test
WORKDIR /app

ENTRYPOINT [ "/app/bin/test" ]