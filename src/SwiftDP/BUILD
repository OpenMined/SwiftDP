load("@build_bazel_rules_apple//apple:ios.bzl", "ios_static_framework")
load("@build_bazel_rules_apple//apple:versioning.bzl", "apple_bundle_version")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

# FRAMEWORKS
# Define the version of the framework
apple_bundle_version(
    name = "framework-version",
    build_version = "0.1",
    short_version_string = "0.1",
)

# Swift Only Framework
swift_library(
    name = "dp-swift",
    module_name = "SwiftDP", # this is the name space for import SwiftDP
    srcs = [
        "fake.swift"
    ],
    deps = [
        "//src/OCDP:dp-objc"
    ],
    alwayslink = True,
    linkopts = ["-lc++"],
    visibility = ["//visibility:public"]
)

ios_static_framework(
    name = "SwiftDP",
    bundle_name = "SwiftDP",
    families = [
        "iphone",
        "ipad",
    ],
    linkopts = ["-lc++"],
    minimum_os_version = "13.0",
    version = ":framework-version",
    deps = [":dp-swift"],
    visibility = ["//visibility:public"]
)