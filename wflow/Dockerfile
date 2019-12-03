# Pull model image
FROM ewatercycle/wflow:2019.1
MAINTAINER Gijs van den Oord <g.vandenoord@esciencecenter.nl>

# Install grpc4bmi
RUN pip3 install grpc4bmi==0.2.1

# Set environment
WORKDIR /data/input
ENV BMI_MODULE=wflow.wflow_bmi
ENV BMI_CLASS=wflowbmi_csdms
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server"]
EXPOSE 55555
