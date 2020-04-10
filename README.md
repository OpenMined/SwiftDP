# SwiftDP

Swift wrapper for Google's Differential Privacy Project.

## TODO

- [x] Bazel Build
- [x] C++ -> Objective-C -> Swift
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

- Xcode
- Brew

```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

- Bazel

```
$ brew tap bazelbuild/tap
$ brew install bazelbuild/tap/bazel
```

- XcodeGen

```
$ brew install xcodegen
```

# Packaging Overview

# Build Framework

```
$ bazel build //src:Hello --ios_multi_cpus=x86_64,arm64 --apple_bitcode=embedded --copt=-fembed-bitcode
```

# Build Example App

```
$ cd xcode
$ xcodegen generate
```

Open SwiftDP-Test-Framework.xcodeproj and add your Team Signing Identity and hit run.

## Useful Commands

### Bazel Clean

```
$ bazel clean --expunge
```

### Inspect iOS Library Files

```
$ otool -hv -arch all $FILENAME
```

```
lipo -info $FILENAME
```

```
nm $FILENAME
```
