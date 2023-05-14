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
USERNAME="takanotaiga"


# Prevent running as root.
if [[ $(id -u) -eq 0 ]]; then
    print_error "Please re-run without sudo."
    exit 1
fi

# Check if user can run docker without root.
RE="\<docker\>"
if [[ ! $(groups $USER) =~ $RE ]]; then
    print_error "User |$USER| is not a member of the 'docker' group and cannot run docker commands without sudo."
    print_error "Run 'sudo usermod -aG docker \$USER && newgrp docker'."
    exit 1
fi

print_info "Environment check complete."

# Check Tag
TAG_PATH="$ROOT/cfg/name.cfg"
if [ -e $TAG_PATH ]; then
    PACKGE_TAG="$( cat $TAG_PATH )"
else
    print_error "Not found cfg file"
    exit 1
fi

# Build docker image
print_info "Build docker image"
docker image build -t $USERNAME/adaos_app:$PACKGE_TAG -f $ROOT/Dockerfile.app $ROOT

print_info "Created environment"

print_info "Start dev container"

docker run --rm -it \
    --privileged \
    --network host \
    -v /dev/*:/dev/* \
    -v $ROOT/:/adaos_workspace/ \
    --entrypoint /usr/local/bin/scripts/app_entrypoint.sh \
    --workdir /adaos_workspace/ \
    $USERNAME/adaos_app:$PACKGE_TAG \
    /bin/bash