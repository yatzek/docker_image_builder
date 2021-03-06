#!/bin/bash

set -ex

if [ $# -ne 2 ] ; then
    echo "App name and app folder path missing, usage: build_node_app.sh app_name app_folder_path"
    exit 1
fi

app_name="$1"
app_folder_path="$2"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# folder "app" with application code & installed modules needs to be available under the bazel target folder
rm -f ${DIR}/nodejs/app
ln -s ${app_folder_path} ${DIR}/nodejs/app

bazel build --define app_name=${app_name} --color=no //nodejs:node_image
bazel run   --define app_name=${app_name} --color=no //nodejs:push_node_image

rm -f ${DIR}/nodejs/app