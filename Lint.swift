// swift-linter-tools-version: 0.1
// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-standards-linter-rules open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-standards-linter-rules project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// Self-lint with the pack's own bundle. swift-standards-linter-rules is the
// standards-rules pack — its `Bundle.standards` is the institute bundle minus
// the two compound-naming rules. Self-linting against this pack's own source
// dogfeeds the bundle it publishes.

import Linter
import Linter_Standards_Rules

Lint.run(dependencies: [
    .package(
        path: ".",
        products: ["Linter Standards Rules"]
    ),
]) {
    Lint.Rule.Bundle.standards
}
