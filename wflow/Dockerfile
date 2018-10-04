# Pull model image
FROM ewatercycle/wflow:bmi_fixes
MAINTAINER Gijs van den Oord <g.vandenoord@esciencecenter.nl>

# Install grpc4bmi
RUN pip install git+https://github.com/eWaterCycle/grpc4bmi.git#egg=grpc4bmi

# Set environment
WORKDIR /data/input
ENV BMI_MODULE=wflow.wflow_bmi
ENV BMI_CLASS=wflowbmi_csdms
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server"]
EXPOSE 55555
