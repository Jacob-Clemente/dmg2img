# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y zlib1g-dev libbz2-dev

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev
## Add source code to the build stage.
ADD . /dmg2img
WORKDIR /dmg2img

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN make

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /dmg2img/dmg2img /
