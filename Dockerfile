ARG GHC_VERSION
ARG DEBIAN_TAG

FROM haskell:${GHC_VERSION}-${DEBIAN_TAG} AS build

# Prepare system
RUN cabal update && \
    apt-get update -qq && \
    apt-get upgrade -qq
