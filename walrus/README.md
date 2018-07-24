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

```

Use client

```python
from grpc4bmi.bmi_client_subproc import BmiClientDocker
mymodel = BmiClientDocker(image='ewatercycle/walrus-grpc4bmi', image_port=55555)
```

# Config

Walrus does not use a config file, bmi requires it. See `./walrus.yml` for example config file which works with https://github.com/ClaudiaBrauer/WALRUS/tree/master/demo/data
