FROM ewatercycle/lisflood:20.10
MAINTAINER Stefan Verhoeven <s.verhoeven@esciencecenter.nl>

# Install grpc4bmi
RUN pip install grpc4bmi==0.2.8

# Set environment
WORKDIR /data/input
ENV BMI_MODULE=bmi_lisflood
ENV BMI_CLASS=LisfloodBmi
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server", "--path", "/opt/Lisflood"]
EXPOSE 55555
