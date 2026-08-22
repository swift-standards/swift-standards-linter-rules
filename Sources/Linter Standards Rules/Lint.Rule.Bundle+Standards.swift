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

public import Institute_Linter_Rule_Naming
public import Linter_Institute_Rules
public import Linter_Primitives

/// Standards-tier rule bundle.
///
/// Equals the institute-tier bundle (which transitively includes the
/// universal bundle) MINUS exactly two naming rules: `compound identifier`
/// (`[API-NAME-002]`) and `compound type name` (`[API-NAME-001]`). A
/// standards-tier consumer pulls this single product and references the
/// bundle by name:
///
/// ```swift
/// let configuration = Lint.Configuration {
///     Lint.Rule.Bundle.standards
/// }
/// ```
///
/// Unlike the additive `universal → institute → primitives` chain, the
/// standards bundle is a **subtractive bundle-level opt-out** (principal
/// ruling 2026-07-07). Layer-2 Standards packages optimize for 1:1 spec
/// encodings, and identifiers that are deterministic transliterations of
/// spec-defined tokens — per the spec community's own naming convention
/// (W3C CSSOM camelCase like `animationName` / `timingFunction`; IEEE 754
/// operation names like `roundAwayFromZero`; POSIX symbols) — are
/// spec-mirroring names governed by `code-surface` `[API-NAME-003]`. The
/// two compound-naming rules would mechanically fire on those legitimate
/// spec-mirrors, so they are opted out at the standards tier. Both rules
/// remain fully active at L1 (primitives) and L3 (foundations); the
/// standards bundle is a sibling of `primitives`, not part of the additive
/// chain.
///
/// The subtraction is expressed via ``excluding(rules:)`` against the
/// institute bundle, so as institute-tier rules are added or removed the
/// standards bundle tracks them automatically — only the two named
/// exclusions are ever removed.
extension Lint.Rule.Bundle {
    /// The standards-tier rule bundle: the institute-tier bundle minus the
    /// two compound-naming rules that spec-token transliterations opt out
    /// of at L2 per `[API-NAME-003]`.
    public static let standards: [Lint.Rule.Configuration] =
        Lint.Rule.Bundle.institute.excluding(rules: [
            // [API-NAME-002] compound method / property identifiers — spec
            // tokens (CSSOM `animationName`, POSIX operation names) mirror
            // the specification and are exempt per [API-NAME-003] at L2.
            Lint.Rule.`compound identifier`.id,
            // [API-NAME-001] compound type names — spec-mirroring type
            // namespaces (IEEE 754 `RoundAwayFromZero`, CSSOM shorthands)
            // are governed by [API-NAME-003] at L2.
            Lint.Rule.`compound type name`.id,
        ])
}
