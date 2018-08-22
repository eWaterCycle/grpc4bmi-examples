A gprc4bmi server for https://github.com/ClaudiaBrauer/WALRUS implemented in R.

Docker image is build automatically at https://hub.docker.com/r/ewatercycle/walrus-grpc4bmi/

# Run

Use [client](https://pypi.org/project/grpc4bmi/)

```python
from grpc4bmi.bmi_client_docker import BmiClientDocker
mymodel = BmiClientDocker(image='ewatercycle/walrus-grpc4bmi', image_port=55555)
```

## Using universal grpc command line client

```bash
docker run -d -p 55555:55555 -v $PWD:/data ewatercycle/walrus-grpc4bmi
wget https://github.com/grpc-ecosystem/polyglot/releases/download/v1.6.0/polyglot.jar
echo '{}' | java -jar polyglot.jar --command=call --endpoint=localhost:55555 --full_method=bmi.BmiService/getComponentName
echo '{config_file:"/data/walrus.yml"}' | java -jar polyglot.jar --command=call --endpoint=localhost:55555 --full_method=bmi.BmiService/initialize
echo '{}' | java -jar polyglot.jar --command=call --endpoint=localhost:55555 --full_method=bmi.BmiService/update
echo '{}' | java -jar polyglot.jar --command=call --endpoint=localhost:55555 --full_method=bmi.BmiService/getCurrentTime
echo '{name:"Q"}' | java -jar polyglot.jar --command=call --endpoint=localhost:55555 --full_method=bmi.BmiService/getValue
```

All the available methods can be found at https://github.com/eWaterCycle/grpc4bmi/blob/master/proto/bmi.proto

# Config

Walrus does not use a config file, but bmi requires it. See `./walrus.yml` for example config file which works with https://github.com/ClaudiaBrauer/WALRUS/tree/master/demo/data

# Build

```bash
docker build -t ewatercycle/walrus-grpc4bmi .
```
