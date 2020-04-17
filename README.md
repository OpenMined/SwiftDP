#SwiftDP

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

- clang-format

```
$ brew install clang-format
```

# Packaging Overview

# Build Framework

```
$ ./build_framework.sh
```

# Xcode Development

All development can be done inside of xcode. We have the Objective-C source code linked a dummy framework to allow for "Jump to Definition" as well as the google absl and dp libraries linked but with no target membership to make it easy to navigate the source.

## Build Example App

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

Show which architectures are available:

```
$ lipo -info ./bazel-bin/src/SwiftDP_archive-root/SwiftDP.framework/SwiftDP
```

```
$ otool -hv -arch all $FILENAME
```

```
$ nm $FILENAME
```
