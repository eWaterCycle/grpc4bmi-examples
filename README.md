# grpc4bmi-examples

Initialize the data with
```
git submodule update --init --recursive
```

Build the docker containers in subfolders
```
docker build -t pcrg-grpc4bmi pcrglob/
docker build -t wflow-grpc4bmi wflow/
```

Install dependencies
```
pip install -r requirements.txt
```

Run notebooks

```
jupyter lab
```
