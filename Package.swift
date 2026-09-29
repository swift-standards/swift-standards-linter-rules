// swift-tools-version: 6.4

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

import PackageDescription

let package = Package(
    name: "swift-standards-linter-rules",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        // Aggregate bundle — publishes `Lint.Rule.Bundle.standards`
        // (= the institute bundle MINUS the two compound-naming rules).
        // Standards-tier (L3) consumers depend on this product alone.
        .library(
            name: "Linter Standards Rules",
            targets: ["Linter Standards Rules"]
        )
    ],
    dependencies: [
        // URL + branch form (mirroring swift-primitives-linter-rules). Local
        // path-form deps are rejected by SwiftPM when this package is itself
        // consumed via a revision/branch requirement (the consumption model:
        // consumers pin `branch: "main"`, resolved to the local clone through
        // ~/Library/org.swift.swiftpm/configuration/mirrors.json). A
        // revision-pinned package may not carry local-path dependencies.
        .package(
            url: "https://github.com/swift-molecules/swift-lint.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-compositions/swift-institute-linter-rules.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Linter Standards Rules",
            dependencies: [
                // The `Lint.Rule.Bundle` / `Lint.Rule.Configuration` vocabulary
                // and the `excluding(rules:)` combinator.
                .product(name: "Lint", package: "swift-lint"),
                // The institute-tier bundle this package subtracts from.
                .product(name: "Linter Institute Rules", package: "swift-institute-linter-rules"),
                // Leaf module for the two excluded rules, referenced by
                // `.id` in the bundle definition. Required directly under
                // SE-0444 MemberImportVisibility ([LINT-BUNDLE-003]).
                .product(name: "Institute Linter Rule Naming", package: "swift-institute-linter-rules"),
            ]
        ),
        .testTarget(
            name: "Linter Standards Rules Tests",
            dependencies: [
                .target(name: "Linter Standards Rules"),
                .product(name: "Lint", package: "swift-lint"),
                .product(name: "Linter Institute Rules", package: "swift-institute-linter-rules"),
                .product(name: "Institute Linter Rule Naming", package: "swift-institute-linter-rules"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableExperimentalFeature("Lifetimes"),
        .treatAllWarnings(as: .error),
    ]
}
