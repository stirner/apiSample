# build stage
FROM golang:1.7.3 as build-env
WORKDIR /go/src/github.com/guipal/apiSample/
RUN go get -d -v github.com/gorilla/mux
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o apiSample .

# final stage
FROM scratch
COPY --from=build-env /go/src/github.com/guipal/apiSample/apiSample /apiSample
CMD ["/apiSample"]
