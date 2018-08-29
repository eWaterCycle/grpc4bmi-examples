FROM r-base
LABEL maintainer="Stefan Verhoeven <s.verhoeven@esciencecenter.nl>"

# TODO replace GitHub url by pypi package name when https://github.com/eWaterCycle/grpc4bmi/pull/10 is merged and grpc4bmi has been published
RUN apt update && apt install -t unstable -y python3-dev python3-pip git && \
  pip3 install git+https://github.com/eWaterCycle/grpc4bmi.git@fixing-install-imports#egg=grpc4bmi[R]

RUN install.r remotes && installGithub.r ClaudiaBrauer/WALRUS eWaterCycle/bmi-r

RUN mkdir /opt/walrus-bmi

COPY walrus-bmi.r /opt/walrus-bmi/walrus-bmi.r

# Config file and forcing file will be mounted at /data
RUN mkdir /data
WORKDIR /data
VOLUME /data

CMD ["run-bmi-server", "--lang", "R", "--path", "/opt/walrus-bmi/walrus-bmi.r", "--name", "WalrusBmi", "--port", "55555"]

EXPOSE 55555