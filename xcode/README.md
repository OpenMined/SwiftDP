# How to use this Demo Project

## Building the iOS Static Framework 

From the root folder run:

```
$ bazel build //src:Hello --ios_multi_cpus=x86_64,arm64 --apple_bitcode=embedded --copt=-fembed-bitcode
```

## Import the iOS Static Framework into the Project

* Unzip `Hello.zip` from `bazel-bin/src`
* Add `Hello.framework` into the Xcode Project (making sure that `copy items if needed` is checked)



