FROM python:3.12.3-alpine

LABEL MAINTAINER="Daniel Pryor <daniel@pryorda.net>"
LABEL NAME=vmware_exporter

WORKDIR /opt/vmware_exporter/
COPY requirements.txt setup.py README.md MANIFEST.in /opt/vmware_exporter/
RUN set -x; buildDeps="gcc python3-dev musl-dev libffi-dev openssl openssl-dev rust cargo" \
 && apk add --no-cache --update $buildDeps \
 && pip install -r requirements.txt \
 && apk del $buildDeps
COPY vmware_exporter/  /opt/vmware_exporter/vmware_exporter
RUN pip install .



EXPOSE 9272

ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["/usr/local/bin/vmware_exporter"]
