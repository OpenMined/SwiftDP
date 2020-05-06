# SwiftDP

Swift wrapper for Google's Differential Privacy Project via an Objective-C++ bridge.

## TODO

- [x] Bazel Build
- [x] C++ -> Objective-C -> Swift
- [x] Development Xcode Project
- [x] clang-format
- [ ] Carrot Hello World
- [ ] DP Framework
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

Open SwiftDP-App.xcodeproj and add your Team Signing Identity and hit run.

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

# Namespaces

## Objective-C

We are using the namespace OCDP in the Objective-C code.

## Swift

We plan to use NS_SWIFT_UNAVAILABLE and NS_SWIFT_NAME to selectively expose and rename the Objective-C API to Swift.

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

## Toolbox

### C++

- Templates
- C++ auto in range-based for-loops

### Objective-C

- Categories
- Objective-C++ .mm files
- `__kindof`
- isMemberOfClass
- isKindOfClass
- Protocols
- Light-weight Generics
- NS_UNAVAILABLE

### Swift

- NS_SWIFT_NAME
- NS_SWIFT_UNAVAILABLE

## Resources

These links have really useful patterns and ideas on ways to mix C++ and Objective-C in novel ways.

https://philjordan.eu/article/strategies-for-using-c++-in-objective-c-projects  
https://philjordan.eu/article/mixing-objective-c-c++-and-objective-c++  
https://useyourloaf.com/blog/using-nullable-to-annotate-objective-c/
https://useyourloaf.com/blog/using-objective-c-lightweight-generics/
https://developer.apple.com/documentation/swift/objective-c_and_c_code_customization
http://mirror.informatimago.com/next/developer.apple.com/releasenotes/Cocoa/Objective-C++.html
https://gist.github.com/dodikk/4a0f1d98faa7c1336551
https://medium.com/@husain.amri/objective-c-deliver-us-from-swift-3a44d3ac00e7
https://medium.com/@husain.amri/creating-objective-c-classes-at-runtime-1f02b3a3a1db
https://academy.realm.io/posts/altconf-peter-steinberger-objective-c++-what-could-possibly-go-wrong/
https://github.com/EmbeddedSources/JFFLibrary/tree/master/lib/JFFUtils
https://www.netguru.com/codestories/objective-c-generics
