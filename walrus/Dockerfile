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
  cd /grpc && make -j 4 && cd third_party/protobuf && make install && cd - && make install && ldconfig && cd /

RUN install.r configr R6 && installGithub.r ClaudiaBrauer/WALRUS nfultz/grpc

RUN mkdir /opt/walrus-bmi

# for debug
RUN apt update && apt install -y nano
WORKDIR /opt/walrus-bmi

#RUN mkdir /data

#WORKDIR /data

COPY bmi.proto *.r /opt/walrus-bmi/

ENV BMI_MODULE=walrus-bmi.r
ENV BMI_CLASS=WalrusBmi
ENV BMI_PORT=55555

CMD ["/opt/walrus-bmi/bmi-server.r"]

EXPOSE 55555
