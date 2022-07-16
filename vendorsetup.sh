#!/usr/bin/env bash

if [ "$(grep zsh <<< "$SHELL")" ]; then
DIR="$(cd -P -- "$(dirname -- "${(%):-%N}")" && pwd -P)"
else
DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
fi

echo 'Downloading latest prebuilt Camera.apk from GrapheneOS...'
camera_dir=/tmp/GrapheneOSCamera
camera_branch=12.1
rm -rf $camera_dir &&
git clone --depth=1 https://github.com/GrapheneOS/platform_external_Camera.git -b $camera_branch $camera_dir &&
mv $camera_dir/prebuilt/Camera.apk "$DIR"/GrapheneCamera/ || echo "Download failed with status code $?"
