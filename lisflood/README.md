Docker image with listflood and grpc4bmi server

Build with
```bash
docker build -t ewatercycle/lisflood-grpc4bmi .
```

Run with
```bash
docker run -d --user $(id -u) -v $PWD/input:/data/input -v $PWD/output:/data/output -p 55551:55555 ewatercycle/lisflood-grpc4bmi:latest
```
Will run lisflood grpc server on port 55551.
