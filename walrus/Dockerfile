FROM r-base
LABEL maintainer="Stefan Verhoeven <s.verhoeven@esciencecenter.nl>"

RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
		libcurl4-openssl-dev curl \
        git \
        build-essential autoconf libtool pkg-config dh-autoreconf \
	&& rm -rf /var/lib/apt/lists/*

RUN echo 'source("https://raw.githubusercontent.com/r-lib/remotes/master/install-github.R")$value("r-lib/remotes")' | R --vanilla

RUN git clone --recursive -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc && \
  cd /grpc && make -j 4 && cd third_party/protobuf && make install && cd - && make install && ldconfig && cd /

# TODO Use nfultz/grpc instead of eWaterCycle/grpc@index-out-of-bounds when proper fix made instead of workaround
RUN installGithub.r ClaudiaBrauer/WALRUS eWaterCycle/grpc4bmi-r

RUN mkdir /opt/walrus-bmi

WORKDIR /opt/walrus-bmi

RUN mkdir /data
WORKDIR /data

COPY walrus-bmi.r /opt/walrus-bmi/walrus-bmi.r

ENV BMI_MODULE=/opt/walrus-bmi/walrus-bmi.r
ENV BMI_CLASS=WalrusBmi
ENV BMI_PORT=55555

CMD ["Rscript", "-e", "grpc4bmi::run()"]

EXPOSE 55555
