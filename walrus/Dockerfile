FROM ewatercycle/grpc4bmi-r
LABEL maintainer="Stefan Verhoeven <s.verhoeven@esciencecenter.nl>"

RUN installGithub.r ClaudiaBrauer/WALRUS

RUN mkdir /opt/walrus-bmi

COPY walrus-bmi.r /opt/walrus-bmi/walrus-bmi.r

ENV BMI_MODULE=/opt/walrus-bmi/walrus-bmi.r
ENV BMI_CLASS=WalrusBmi
