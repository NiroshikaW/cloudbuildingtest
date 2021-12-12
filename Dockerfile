FROM golang:1.13 AS build


ENV GONOPROXY="gitlab.com"
ENV GOPRIVATE="gitlab.com"

ARG USERNAME
ARG PASSWORD

RUN echo "machine gitlab.com login ${USERNAME} password ${PASSWORD}" > ~/.netrc

WORKDIR /
ADD . /

RUN go build -o main -a /main.go

FROM gcr.io/distroless/base
COPY --from=build /main /
ENTRYPOINT [ "/main" ]

 
# final stage
FROM alpine:3.10
RUN apk --no-cache add ca-certificates
COPY --from=build /main ./
RUN chmod +x ./main
ENTRYPOINT ["./main"]
EXPOSE 8002
