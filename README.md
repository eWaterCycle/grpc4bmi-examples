# grpc4bmi-examples

Initialize the data with
```
git submodule update --init --recursive
```

Build the docker containers in subfolders
```
docker build -t pcrg-grpc4bmi pcrglob/
docker build -t wflow-grpc4bmi wflow/
docker build -t ewatercycle/walrus-grpc4bmi walrus
```

Install dependencies
```
sudo apt install subversion
pip install -r requirements.txt
```

Install helper module

```
cd psfetch
flit install -s
cd ..
```

Run notebooks

```
jupyter lab
```
