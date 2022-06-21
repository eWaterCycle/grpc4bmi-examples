# Pull model image
FROM jpmaerts/pcr-globwb_model:bmi_fixes_conda
MAINTAINER Jerom Aerts <j.p.m.aerts@tudelft.nl>

# Activate conda environment
# Override default shell and use bash
# SHELL ["conda", "run", "-n", "pcrglobwb_python3", "/bin/bash", "-c"]
# ENV PYTHONPATH /usr/bin/python3/
# Install grpc4bmi
RUN pip install grpc4bmi==0.2.4

# Set environment
WORKDIR /opt
ENV BMI_MODULE=bmiPcrglobwb
ENV BMI_CLASS=BmiPCRGlobWB
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server","--path","/opt/PCR-GLOBWB_model/model"]
EXPOSE 55555
