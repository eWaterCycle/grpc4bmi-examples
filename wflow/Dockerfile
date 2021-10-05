# Pull model image
FROM ewatercycle/wflow:2020.1.2
LABEL maintainer=s.verhoeven@esciencecenter.nl

# Install grpc4bmi
RUN pip install grpc4bmi==0.2.*

# Set environment
WORKDIR /data/input
ENV BMI_MODULE=wflow.wflow_bmi
ENV BMI_CLASS=wflowbmi_csdms
ENV BMI_PORT=55555
ENTRYPOINT ["run-bmi-server"]
EXPOSE 55555
