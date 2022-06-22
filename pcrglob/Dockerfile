# Pull model image
FROM jpmaerts/pcr-globwb_model:bmi_fixes_conda
LABEL maintainer="Jerom Aerts <j.p.m.aerts@tudelft.nl>"

# Install grpc4bmi
RUN conda run -n pcrglobwb_python3 pip install git+https://github.com/eWaterCycle/grpc4bmi.git#egg=grpc4bmi

# Set environment
WORKDIR /opt
ENV BMI_MODULE=bmiPcrglobwb
ENV BMI_CLASS=BmiPCRGlobWB
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server","--path","/opt/PCR-GLOBWB_model/model"]
EXPOSE 55555
