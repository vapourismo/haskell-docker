ARG GHC_VERSION
ARG DEBIAN_TAG

FROM haskell:${GHC_VERSION}-${DEBIAN_TAG}

# Install fixed cabal-install
RUN cabal update && \
    mkdir -p /opt/cabal-new/bin && \
    cabal install \
        cabal-install \
        --constraint='lukko -ofd-locking' \
        --install-method=copy \
        --installdir=/opt/cabal-new/bin \
        --overwrite-policy=always && \
    rm -rf /opt/cabal/* && \
    mv /opt/cabal-new/* /opt/cabal && \
    rm -rf ~/.cabal

# Make new cabal-install available
ENV PATH=/opt/cabal/bin:$PATH
