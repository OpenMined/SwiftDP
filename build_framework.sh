#!/bin/sh
bazel build //src:SwiftDP --ios_multi_cpus=x86_64,arm64 --apple_bitcode=embedded --copt=-fembed-bitcode