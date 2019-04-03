FROM ec-jrc/lisflood
MAINTAINER Stefan Verhoeven <s.verhoeven@esciencecenter.nl>

# Install grpc4bmi
RUN pip install git+https://github.com/eWaterCycle/grpc4bmi.git#egg=grpc4bmi

# Set environment
WORKDIR /data/input
ENV BMI_MODULE=bmi_test
ENV BMI_CLASS=LisfloodBmi
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server", "--path", "/opt/Lisflood"]
EXPOSE 55555
