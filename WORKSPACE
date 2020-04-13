workspace(name = "SwiftDP")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

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


load(
    "@build_bazel_rules_apple//apple:repositories.bzl",
    "apple_rules_dependencies",
)

apple_rules_dependencies()

load("@google_differential_privacy//:differential_privacy_deps.bzl", "differential_privacy_deps")

differential_privacy_deps()

