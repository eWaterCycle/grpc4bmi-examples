# Pull model image
FROM ewatercycle/pcr-globwb_model:bmi_fixes
MAINTAINER Gijs van den Oord <g.vandenoord@esciencecenter.nl>

# Install grpc4bmi
RUN pip install grpc4bmi==0.2.4

# Set environment
WORKDIR /opt
ENV BMI_MODULE=bmiPcrglobwb
ENV BMI_CLASS=BmiPCRGlobWB
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server","--path","/opt/PCR-GLOBWB_model/model"]
EXPOSE 55555
