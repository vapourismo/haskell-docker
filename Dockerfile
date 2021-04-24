ARG GHC_VERSION
ARG DEBIAN_TAG

FROM haskell:${GHC_VERSION}-${DEBIAN_TAG}

# Prepare system
RUN cabal update && \
    apt-get update -qq && \
    apt-get upgrade -qq

# Install fixed cabal-install
RUN mkdir -p /opt/cabal-new/bin && \
    cabal install \
        cabal-install \
        --constraint='lukko -ofd-locking' \
        --install-method=copy \
        --installdir=/opt/cabal-new/bin \
        --overwrite-policy=always && \
    mv /opt/cabal-new/ /opt/cabal/

# Make new cabal-install available
ENV PATH=/opt/cabal/bin:$PATH
