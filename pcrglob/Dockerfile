# Pull model image
FROM jpmaerts/pcr-globwb_model:bmi_fixes_conda
LABEL maintainer="Jerom Aerts <j.p.m.aerts@tudelft.nl>"

# Install grpc4bmi
RUN conda run -n pcrglobwb_python3 pip install protobuf==3.20.*
RUN conda run -n pcrglobwb_python3 pip install grpc4bmi==0.2.*

# Set environment
WORKDIR /opt
ENV BMI_MODULE=bmiPcrglobwb
ENV BMI_CLASS=BmiPCRGlobWB
ENV BMI_PORT=55555

# set entrypoint
ENTRYPOINT ["/opt/conda/envs/pcrglobwb_python3/bin/run-bmi-server","--path","/opt/PCR-GLOBWB_model/model"]
EXPOSE 55555