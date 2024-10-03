# wflow grpc4bmi

To make the image, follow the instruction described below.

- wflow image:
    wflow docker file is available
    [on forked wflow repository in eWaterCycle](https://github.com/eWaterCycle/wflow/tree/docker-fixes-2020.1.1)
    branch `docker-fixes-2020.1.1`.

    To build and push the docker image:

    ```bash
    cd path_to_forked_wflow_repository
    docker build -t ewatercycle/wflow:{version_tag} .
    docker push ewatercycle/wflow:{version_tag}
    ```

    Now wflow docker image with tag `latest` is available [on dockerhub](https://hub.docker.com/r/ewatercycle/wflow).

    Then we should replace the tag mentioned in grpc4bmi Dockerfile,
    [(see first line)](https://github.com/eWaterCycle/grpc4bmi-examples/blob/master/wflow/Dockerfile)
    with the `version_tag` of `ewatercycle/wflow:{version_tag}`.

- wflow-grpc4bmi image:
    wflow-grpc4bmi docker file is available
    [on grpc4bmi-examples repository](https://github.com/eWaterCycle/grpc4bmi-examples/blob/master/wflow/Dockerfile).

    To build and push the docker image:

    ```bash
    cd path_to_grpc4bmi-examples_repository/wflow
    docker build -t ewatercycle/wflow-grpc4bmi:{version_tag} .
    docker push ewatercycle/wflow-grpc4bmi:{version_tag}
    ```

    Now wflow-grpc4bmi docker image with tag `latest` is available [on dockerhub](https://hub.docker.com/r/ewatercycle/wflow-grpc4bmi).
