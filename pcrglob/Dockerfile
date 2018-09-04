# Pull model image
FROM ewatercycle/pcr-globwb_model:latest
MAINTAINER Gijs van den Oord <g.vandenoord@esciencecenter.nl>

# Install grpc4bmi
RUN pip install git+https://github.com/eWaterCycle/grpc4bmi.git#egg=grpc4bmi

# Set environment
WORKDIR /opt
ENV BMI_MODULE=bmiPcrglobwb
ENV BMI_CLASS=BmiPCRGlobWB
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server","--path","/opt/PCR-GLOBWB_model/model"]
EXPOSE 55555
