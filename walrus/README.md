A gprc4bmi server for https://github.com/ClaudiaBrauer/WALRUS implemented in R.

# Deps

See Dockerfile

Proto file source is https://github.com/eWaterCycle/grpc4bmi/raw/master/proto/bmi.proto

# Build

```bash
docker build -t ewatercycle/walrus-grpc4bmi .
```

# Run

```bash
docker run -d ewatercycle/walrus-grpc4bmi
wget https://github.com/grpc-ecosystem/polyglot/releases/download/v1.6.0/polyglot.jar
echo '{}' | java -jar polyglot.jar --command=list_services --proto_discovery_root=$PWD
echo '{}' | java -jar polyglot.jar --command=call --endpoint=172.17.0.5:55555 --full_method=bmi.BmiService/getComponentName --proto_discovery_root=$PWD --use_reflection=false
echo '{config_file:"walrus.yml"}' | java -jar polyglot.jar --command=call --endpoint=172.17.0.5:55555 --proto_discovery_root=$PWD --use_reflection=false --full_method=bmi.BmiService/initialize
echo '{}' | java -jar polyglot.jar --command=call --endpoint=172.17.0.5:55555 --proto_discovery_root=$PWD --use_reflection=false --full_method=bmi.BmiService/update
echo '{}' | java -jar polyglot.jar --command=call --endpoint=172.17.0.5:55555 --proto_discovery_root=$PWD --use_reflection=false --full_method=bmi.BmiService/getCurrentTime
echo '{name:"Q"}' | java -jar polyglot.jar --command=call --endpoint=172.17.0.5:55555 --proto_discovery_root=$PWD --use_reflection=false --full_method=bmi.BmiService/getValue
```
(where `172.17.0.5` is the IP of the Docker container)

Use client

```python
from grpc4bmi.bmi_client_subproc import BmiClientDocker
mymodel = BmiClientDocker(image='ewatercycle/walrus-grpc4bmi', image_port=55555)
```

To run server in debug mode use
```bash
docker run -ti ewatercycle/walrus-grpc4bmi bash
GRPC_TRACE=api GRPC_VERBOSITY=DEBUG ./bmi-server.r
```

# Config

Walrus does not use a config file, bmi requires it. See `./walrus.yml` for example config file which works with https://github.com/ClaudiaBrauer/WALRUS/tree/master/demo/data


# Generated cpp 

The [library(grpc)](https://github.com/nfultz/grpc) is missing reflection and error handling, we could use `protoc` to generate cpp server stub and call R functions in the stub.

```
protoc -I . --grpc_out=. --plugin=protoc-gen-grpc=`which grpc_cpp_plugin` ./bmi.proto
protoc -I . --cpp_out=. ./bmi.proto
```
