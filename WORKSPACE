workspace(name = "SwiftDP")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

git_repository(
    name = "build_bazel_rules_apple",
    remote = "https://github.com/bazelbuild/rules_apple.git",
    commit = "5131f3d46794bf227d296c82f30c2499c9de3c5b",
)

git_repository(
    name = "google_differential_privacy",
    commit = "14f26fb91570cce384c2715d3adcaa4e92eec605",
    remote = "https://github.com/google/differential-privacy"
)  

# needed for protobuf
http_archive(
    name = "zlib",
    build_file = "//third_party:zlib.BUILD",
    sha256 = "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
    strip_prefix = "zlib-1.2.11",
    urls = [
        "http://mirror.bazel.build/zlib.net/fossils/zlib-1.2.11.tar.gz",
        "http://zlib.net/fossils/zlib-1.2.11.tar.gz",  # 2017-01-15
    ],
)


load(
    "@build_bazel_rules_apple//apple:repositories.bzl",
    "apple_rules_dependencies",
)

apple_rules_dependencies()

load("@google_differential_privacy//:differential_privacy_deps.bzl", "differential_privacy_deps")

differential_privacy_deps()

