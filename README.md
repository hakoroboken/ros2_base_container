# ros2_base_container

## Quickstart
### Create workspace
1. Setup Docker
2. Docker without sudo
    ```
    sudo usermod -aG docker $USER && newgrp docker
    sudo systemctl daemon-reload && sudo systemctl restart docker
    ```
3. get ws_init scripts
    ```
    wget https://raw.githubusercontent.com/hakoroboken/ros2_base_container/main/ws_init.sh
    chmod +x ./ws_init.sh
4. create workspace
    ```
    ./ws_init.sh WORKSPACE-NAME
    ```
5. check workspace
    ```
    $ cd ./WORKSPACE-NAME
    $ ls
    app_entrypoint.sh  cfg  colcon_run.sh  Dockerfile.app  src
    ```

### Edit workspace

- app_entrypoint.sh
    - This file is called upon during container startup. It is primarily suitable for executing commands such as "colcon build" and "ros2 run".
- Dockerfile.app 
    - This file is used to build the container. The execution details of the command will be cached. It is ideal for executing the 'apt install' command.
- src directry
    - Workspace directory is mounted inside the container. Placing the source code of ROS packages in the "src" directory is optimal.

### Run
```
./colcon_run.sh
```