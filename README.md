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
docker build -t ewatercycle/lisflood-grpc4bmi lisflood/
```

Install dependencies
```
sudo apt install subversion
pip install -r requirements.txt
```

# Run

Run notebooks

```
jupyter lab
```

# Test with

```python
import ewatercycle.parameter_sets
ps = ewatercycle.parameter_sets.get_parameter_set('wflow_rhine_sbm_nc')
import ewatercycle.models
model = ewatercycle.models.Wflow(version='2020.1.2', parameter_set=ps)
cfg_file, cfg_dir = model.setup()
model.initialize(cfg_file)
model.update()
model.output_var_names
print(model.bmi.logs())
model.finalize()
```