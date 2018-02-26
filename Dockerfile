FROM alpine

MAINTAINER Mohammed A.Imran <secfigo@gmail.com>

ENV PYTHONUNBUFFERED 1
ENV user=bandit

# install python and bandit 
RUN echo "**** install runtime packages ****"      && \
    apk add --no-cache py2-pip python2 bash        && \
    echo "**** install pip packages ****"          && \
    pip install --no-cache-dir -U pip              && \
    pip install --no-cache-dir -U bandit           && \
    echo "**** clean up ****"                      && \
    mkdir -p /src                                  && \
    mkdir -p /report                               && \
    mkdir -p /bandit                               && \
    echo "**** user creation ****"                 && \
    addgroup -S bandit                             && \
    adduser -D -S -h /src -G bandit bandit         && \
    chown -R bandit:bandit /src /report /bandit

USER ${user}

VOLUME ["/src" "/report"]

WORKDIR /src

COPY bandit /bandit

CMD ["/bandit/bandit.sh"]
