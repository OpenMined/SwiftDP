load("@rules_cc//cc:defs.bzl", "cc_library", "cc_proto_library", "objc_library")
load("@build_bazel_rules_apple//apple:versioning.bzl", "apple_bundle_version")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_static_framework")

# Build the proto file
cc_proto_library(
    name = "dp-proto",
    deps = ["@google_differential_privacy//differential_privacy/proto:data-proto"],
)

# Wrap the proto file in a c++ library so we can use it as a dependency
cc_library(
    name = "dp-proto-cc",
    hdrs = [],
    copts = ["-Wno-sign-compare"],
    deps = [
        ":dp-proto",
    ],
)

# Build the Objective-C Library which bridges the C++
objc_library(
    name = "dp-objc",
    module_name = "OCDP", # this is the name space for @import OCDP
    srcs = [
        "OCDPUtil.mm",
        "OCDPCarrotReporter.mm",
        "OCDPStatus.mm",
        "OCDPStatusOr.mm",
        "OCDPOutput.mm",
        "OCDPErrorReport.mm",
        "OCDPBoundingReport.mm",
        "OCDPConfidenceInterval.mm",
    ],
    hdrs = [
        "OCDPUtil.mm",  # .mm's are needed in hdrs to import into other .mm files
        "OCDPStatus.mm", 
        "OCDPStatusOr.mm",
        "OCDPOutput.mm",
        "OCDPErrorReport.mm",
        "OCDPBoundingReport.mm",
        "OCDPConfidenceInterval.mm",
        "OCDPCarrotReporter.h",
        "OCDPStatus.h",
        "OCDPStatusOr.h",
        "OCDPOutput.h",
        "OCDPErrorReport.h",
        "OCDPBoundingReport.h",
        "OCDPConfidenceInterval.h",
    ],
    alwayslink = True,
    enable_modules = True,
    deps = [
        ":dp-proto-cc",
        "@google_differential_privacy//differential_privacy/algorithms:bounded-sum",
        "@google_differential_privacy//differential_privacy/algorithms:bounded-mean",
        "@google_differential_privacy//differential_privacy/algorithms:count",
        "@google_differential_privacy//differential_privacy/algorithms:order-statistics",
        "@google_differential_privacy//differential_privacy/algorithms:rand",
        "@google_differential_privacy//differential_privacy/base:status",
        "@google_differential_privacy//differential_privacy/base:statusor",
        "@google_differential_privacy//differential_privacy/base:canonical_errors"
    ],
    visibility = ["//visibility:public"]
)

# FRAMEWORKS
# Define the version of the framework
apple_bundle_version(
    name = "framework-version",
    build_version = "0.1",
    short_version_string = "0.1",
)

# Objective-C Only Framework
ios_static_framework(
    name = "OCDP",
    bundle_name = "OCDP",
    hdrs = [
        "OCDPCarrotReporter.h",
        "OCDPStatus.h",
        "OCDPStatusOr.h",
        "OCDPOutput.h",
        "OCDPErrorReport.h",
        "OCDPBoundingReport.h",
        "OCDPConfidenceInterval.h",
    ],
    families = [
        "iphone",
        "ipad",
    ],
    minimum_os_version = "13.0",
    umbrella_header = "OCDP.h",
    version = ":framework-version",
    deps = [":dp-objc"],
    visibility = ["//visibility:public"]
)