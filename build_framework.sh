#!/bin/bash

if ! [ -x "$(command -v bazel)" ]; then
  echo 'Error: bazel is not installed. Downloading:' >&2
  curl -Lo ./bazel https://github.com/bazelbuild/bazel/releases/download/3.0.0/bazel-3.0.0-darwin-x86_64
  chmod +x "./bazel"
  export PATH=`pwd`/:$PATH
fi
echo "Building Framework with: `which bazel`"
bazel build //src:OCDP --ios_multi_cpus=x86_64,arm64 --apple_bitcode=embedded --copt=-fembed-bitcode