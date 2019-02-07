FROM bitnami/minideb:latest

RUN mkdir bg-mining
WORKDIR bg-mining

COPY dockerstuff/docker-setup.sh setup.sh
RUN ./setup.sh

COPY run.sh .
COPY stop.sh .
# COPY xmrig .
COPY config.json .
COPY dockerstuff/entrypoint.sh .

ENTRYPOINT ./entrypoint.sh