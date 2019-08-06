FROM r-base
LABEL maintainer="Stefan Verhoeven <s.verhoeven@esciencecenter.nl>"

RUN apt update && apt install -t unstable -y python3-dev python3-pip git && \
  git clone -b newest-bmi-support https://github.com/eWaterCycle/grpc4bmi.git /tmp/grpc4bmi && \
  pip3 install /tmp/grpc4bmi[R] && \
  rm -rf /tmp/grpc4bmi && \
  # pip3 install git+https://github.com/eWaterCycle/grpc4bmi.git#egg=grpc4bmi[R]
  install.r remotes && installGithub.r ClaudiaBrauer/WALRUS eWaterCycle/bmi-r@newest-bmi-support && \
  mkdir /opt/walrus-bmi

COPY walrus-bmi.r /opt/walrus-bmi/walrus-bmi.r

# Config file and forcing file will be mounted at /data
RUN mkdir /data
WORKDIR /data
VOLUME /data

ENV BMI_PORT=55555

CMD ["run-bmi-server", "--lang", "R", "--path", "/opt/walrus-bmi/walrus-bmi.r", "--name", "WalrusBmi"]

EXPOSE 55555

HEALTHCHECK --interval=1s --start-period=15s --timeout=3s CMD wget --quiet --tries=1 --spider http://localhost:$BMI_PORT || exit 1
