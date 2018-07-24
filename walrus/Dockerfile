FROM r-base
LABEL maintainer="Stefan Verhoeven <s.verhoeven@esciencecenter.nl>"

RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
		libcurl4-openssl-dev curl \
        git \
        # protobuf-compiler libprotobuf-dev libprotoc-dev \
        build-essential autoconf libtool pkg-config dh-autoreconf \
	&& rm -rf /var/lib/apt/lists/*

RUN echo 'source("https://raw.githubusercontent.com/r-lib/remotes/master/install-github.R")$value("r-lib/remotes")' | R --vanilla

RUN git clone --recursive -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc && \
  cd /grpc && make -j 4 && make install && ldconfig && cd /

RUN installGithub.r ClaudiaBrauer/WALRUS nfultz/grpc && install.r configr R6

RUN mkdir /opt/walrus-bmi

COPY bmi.proto /opt/walrus-bmi/bmi.proto
COPY walrus-bmi-server.r /usr/bin/

RUN mkdir /data

WORKDIR /data

ENV BMI_MODULE=walrus-bmi.r
ENV BMI_PORT=55555

CMD ['/usr/bin/walrus-bmi-server.r']

EXPOSE 55555