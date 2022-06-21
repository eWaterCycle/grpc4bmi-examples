# Pull model image
FROM jpmaerts/pcr-globwb_model:bmi_fixes_conda
MAINTAINER Jerom Aerts <j.p.m.aerts@tudelft.nl>

# Install grpc4bmi
RUN pip install grpc4bmi==0.2.4

# Set environment
WORKDIR /opt
ENV BMI_MODULE=bmiPcrglobwb
ENV BMI_CLASS=BmiPCRGlobWB
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server","--path","/opt/PCR-GLOBWB_model/model"]
EXPOSE 55555
