#SwiftDP

Swift wrapper for Google's Differential Privacy Project.

## TODO

- [x] Bazel Build
- [x] C++ -> Objective-C -> Swift
- [x] Development Xcode Project
- [x] clang-format
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

# Setup

There is a start script which will fetch the bazel dependencies build the framework and
create an xcode project for use in development.

```
$ ./start.sh
```

# Packaging Overview

## Build Framework

```
$ ./build_framework.sh
```

## Xcode Development

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

# How to Objective-C++

## Utility Library

We have a utility library of functions which help converting from C++ to Objective-C and back as needed.

The file is called DPUtil.mm and has no header, which allows it to freely mix C++ and Objective-C into the *franken*code that is Objective-C++.

To make the file available for import its listed in the Bazel BUILD objc_library hdrs.

## Initializers

Mark types with nonnull if you want to return an Implicitly Unwrapped Optional (IOU) in Swift.

```
- (nonnull instancetype) initWithEpsilon: (double) epsilon; // return ! IUO
```

To mark as optional use nullable:

```
- (nullable instancetype) initWithEpsilon: (double) epsilon; // return ? Optional
```

Hide unused init / new:

```
- (instancetype)init NS_UNAVAILABLE; // disable default initializers
+ (instancetype)new NS_UNAVAILABLE; // disable default new aka [[NSObject alloc] init]
```

## Resources

https://philjordan.eu/article/strategies-for-using-c++-in-objective-c-projects  
https://philjordan.eu/article/mixing-objective-c-c++-and-objective-c++  
https://useyourloaf.com/blog/using-nullable-to-annotate-objective-c/
