FROM golang:1.13 AS build


WORKDIR /
ADD . /

RUN go build -o main -a /main.go

FROM gcr.io/distroless/base
COPY --from=build /main /
ENTRYPOINT [ "/main" ]
