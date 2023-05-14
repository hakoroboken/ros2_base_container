#!/bin/bash
# Copyright 2023 Hakoroboken
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function print_error {
    tput setaf 1
    echo "$1"
    tput sgr0
}

function print_warning {
    tput setaf 3
    echo "$1"
    tput sgr0
}

function print_info {
    tput setaf 2
    echo "$1"
    tput sgr0
}

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


# Check Arg
if [ $# -eq 0 ]; then
    print_error "Not found pkg name"
    exit 1
fi

mkdir -p $ROOT/$1/src
mkdir -p $ROOT/$1/cfg
echo -n "$1" >> $ROOT/$1/cfg/name.cfg


cd $ROOT/$1/
wget -q -nc https://raw.githubusercontent.com/hakoroboken/ros2_base_container/main/template/Dockerfile.app
wget -q -nc https://raw.githubusercontent.com/hakoroboken/ros2_base_container/main/template/app_entrypoint.sh
wget -q -nc https://raw.githubusercontent.com/hakoroboken/ros2_base_container/main/template/colcon_run.sh