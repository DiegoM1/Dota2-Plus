#!/bin/sh
# Type a script or drag a script file from your workspace to insert its path.
if [ -z "$CI" ]; then
    ${PODS_ROOT}/SwiftLint/swiftlint
fi

