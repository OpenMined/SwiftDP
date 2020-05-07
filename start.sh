#!/bin/bash
echo "==========================================="
echo "Running: bazel clean --expunge"
echo "==========================================="
bazel clean --expunge
echo "==========================================="
echo "Running: build_frameworks.sh"
source build_frameworks.sh
echo "Bazel Dependencies Fetched and Built"
echo "==========================================="
echo "Running: xcodegen"
cd xcode && xcodegen generate
echo "Xcode Project Generated 🔧"
echo "==========================================="
echo ""
echo "Setup Complete 🚀"
echo "Run:"
echo "open ./xcode/SwiftDP-App.xcodeproj"
echo ""