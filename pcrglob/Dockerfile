# Pull model image
FROM ewatercycle/pcr-globwb_model:bmi_fixes
MAINTAINER Gijs van den Oord <g.vandenoord@esciencecenter.nl>

# Install grpc4bmi
#RUN pip install git+https://github.com/eWaterCycle/grpc4bmi.git#egg=grpc4bmi
RUN git clone -b newest-bmi-support https://github.com/eWaterCycle/grpc4bmi.git /tmp/grpc4bmi && \
  pip install /tmp/grpc4bmi && \
  rm -rf /tmp/grpc4bmi && \

# Set environment
WORKDIR /opt
ENV BMI_MODULE=bmiPcrglobwb
ENV BMI_CLASS=BmiPCRGlobWB
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server","--bmi-version","0.2","--path","/opt/PCR-GLOBWB_model/model"]
EXPOSE 55555
