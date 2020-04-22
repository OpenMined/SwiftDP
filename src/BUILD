load("@rules_cc//cc:defs.bzl", "objc_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_static_framework")
load("@build_bazel_rules_apple//apple:versioning.bzl", "apple_bundle_version")

# Build the Objective-C Library which bridges the C++
objc_library(
    name = "dp",
    deps = [
        "@google_differential_privacy//differential_privacy/algorithms:rand",
        "@google_differential_privacy//differential_privacy/base:status",
        "@google_differential_privacy//differential_privacy/base:statusor",
        #"@google_differential_privacy//differential_privacy/algorithms:bounded-sum",
        #"@google_differential_privacy//differential_privacy/proto:data_cc_proto"
        #"@google_differential_privacy//differential_privacy/example:animals_and_carrots"
    ],
    srcs = [
        "DPUtil.mm",
        "SwiftDP_rand.mm",
        "SwiftDP_status.mm",
        "SwiftDP_CarrotReporter.mm"
    ],
    hdrs = [
        "DPUtil.mm", # needed to import into other .mm files
        "SwiftDP_rand.h",
        "SwiftDP_status.h",
        "SwiftDP_CarrotReporter.h"
    ],
    enable_modules = True,
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
  bundle_name = "SwiftDP",
  families = ["iphone", "ipad"],
  minimum_os_version = "13.0",
  version = ":framework-version",
  umbrella_header = "SwiftDP.h",
  hdrs = [
        "SwiftDP_rand.h",
        "SwiftDP_status.h",
        "SwiftDP_CarrotReporter.h"
    ],
  deps = [":dp"]
)
