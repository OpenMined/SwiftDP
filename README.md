# SwiftDP

Swift wrapper for Google's Differential Privacy Project.

## TODO

- [ ] Bazel Build
- [ ] Tulsi
- [ ] DP Framework
- [ ] Carrot Hello World
- [ ] CI Builds
- [ ] SwiftPM Support
- [ ] Cocopods Support
- [ ] Carthage Support
- [ ] Native iOS Example
- [ ] React Native Example
- [ ] Flutter Example

## Prerequisites

## Setup

# Packaging Overview

# Build Framework

```
$ bazel build //src:Hello --ios_multi_cpus=x86_64,arm64 --apple_bitcode=embedded --copt=-fembed-bitcode
```

# Build Example App

## Useful Commands

otool -hv -arch all
lipo -info libHelloObjC.a

bazel clean --expunge
nm Hello
