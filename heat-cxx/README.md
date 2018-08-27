Wrap the bmi cxx heat model (https://github.com/csdms/bmi-cxx/tree/master/heat) in grpc4bmi

Use the cpp_support branch of https://github.com/eWaterCycle/grpc4bmi repo.


Compile bmi heat 
```bash
git clone git@github.com:csdms/bmi-cxx.git
cd bmi-cxx
mkdir build
cd build
cmake ..
make
```

Compile grpc4bmi
```bash
git clone git@github.com:eWaterCycle/grpc4bmi.git
cd grpc4bmi
git checkout cpp_support
cd cpp
make
```

Compile heat-grpc4bmi
```

```