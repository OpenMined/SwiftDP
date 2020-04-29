load("@rules_cc//cc:defs.bzl", "cc_library", "cc_proto_library", "objc_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_static_framework")
load("@build_bazel_rules_apple//apple:versioning.bzl", "apple_bundle_version")

cc_proto_library(
    name = "my-proto",
    deps = ["@google_differential_privacy//differential_privacy/proto:data-proto"],
)

cc_library(
    name = "my-proto-cc",
    hdrs = [],
    copts = ["-Wno-sign-compare"],
    deps = [
        ":my-proto",
    ],
)

# Build the Objective-C Library which bridges the C++
objc_library(
    name = "dp",
    srcs = [
        "DPUtil.mm",
        "OCDPCarrotReporter.mm",
        "OCDPStatus.mm",
    ],
    hdrs = [
        "DPUtil.mm",  # needed to import into other .mm files
        "OCDPCarrotReporter.h",
        "OCDPStatus.h",
    ],
    enable_modules = True,
    deps = [
        ":my-proto-cc",
        "@google_differential_privacy//differential_privacy/algorithms:bounded-sum",
        "@google_differential_privacy//differential_privacy/algorithms:rand",
        "@google_differential_privacy//differential_privacy/base:status",
        "@google_differential_privacy//differential_privacy/base:statusor",
    ],
)

# Define the version of the framework
apple_bundle_version(
    name = "framework-version",
    build_version = "0.1",
    short_version_string = "0.1",
)

# Build an iOS Static Framework .a file
# TODO figure out optimal minimum target version and supported architectures
# iPhone 5C is the oldest non arm64 device with a max iOS version of 12
ios_static_framework(
    name = "SwiftDP",
    hdrs = [
        "OCDPCarrotReporter.h",
        "OCDPStatus.h",
    ],
    bundle_name = "SwiftDP",
    families = [
        "iphone",
        "ipad",
    ],
    minimum_os_version = "13.0",
    umbrella_header = "SwiftDP.h",
    version = ":framework-version",
    deps = [":dp"],
)
