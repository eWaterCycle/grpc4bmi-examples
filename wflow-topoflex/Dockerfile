# Pull model image
FROM ewatercycle/wflow:bmi_fixes
MAINTAINER Ronald van Haren <r.vanharen@esciencecenter.nl>

# update repo
RUN apt-get update -y

# install compiler and build tools
RUN apt-get install -y git python3-pip

# Install grpc4bmi
RUN pip3 install git+https://github.com/eWaterCycle/grpc4bmi.git

# Set environment
WORKDIR /data/input
ENV BMI_MODULE=wflow.wflow_bmi
ENV BMI_CLASS=wflowbmi_csdms
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server"]
EXPOSE 55555
