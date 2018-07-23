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
```

Use client

```python
from grpc4bmi.bmi_client_subproc import BmiClientDocker
mymodel = BmiClientDocker(image='ewatercycle/walrus-grpc4bmi', image_port=55555)
```

# Config

Walrus does not use a config file, bmi requires it. See `./walrus.yml` for example config file which works with https://github.com/ClaudiaBrauer/WALRUS/tree/master/demo/data
