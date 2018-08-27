# grpc4bmi-examples

The repo contains Jupyter Notebooks that run hydrology models in Docker containers via [grpc4bmi](https://github.com/eWaterCycle/grpc4bmi).

# Installation

Initialize the data with
```
git submodule update --init --recursive
```

The Docker images are automatically build on https://hub.docker.com/u/ewatercycle/

Build the Docker images locally in subfolders
```
docker build -t ewatercycle/pcrg-grpc4bmi pcrglob/
docker build -t ewatercycle/wflow-grpc4bmi wflow/
docker build -t ewatercycle/walrus-grpc4bmi walrus/
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

# Run

Run notebooks

```
jupyter lab
```
