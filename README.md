# grpc4bmi-examples

Initialize the data with
```
git submodule update --init --recursive
```

Build the docker containers in subfolders
In pcrg:
```
docker build -t pcrg-grpc4bmi .
```
In wflow:
```
docker build -t wflow-grpc4bmi .
```

Install dependencies
```
pip install grpc4bmi jupyterlab matplotlib
```

Run notebooks
