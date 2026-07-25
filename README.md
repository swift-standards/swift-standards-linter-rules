# Standards Linter Rules

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)
[![CI](https://github.com/swift-standards/swift-standards-linter-rules/actions/workflows/ci.yml/badge.svg)](https://github.com/swift-standards/swift-standards-linter-rules/actions/workflows/ci.yml)

The standards-tier (L2) rule bundle for [swift-linter](https://github.com/swift-foundations/swift-linter): the institute-tier bundle with exactly two naming rules subtracted, published as a single bundle, `Lint.Rule.Bundle.standards`.

Layer-2 Standards packages optimize for 1:1 spec encodings. Identifiers that are deterministic transliterations of spec-defined tokens — per the specification community's own naming convention (W3C CSSOM camelCase like `animationName` / `timingFunction`; IEEE 754 operation names like `roundAwayFromZero`; POSIX symbols) — are spec-mirroring names, which the institute's naming conventions explicitly permit. The two compound-naming rules would mechanically fire on those legitimate spec-mirrors, so they are opted out at the standards tier. Both rules remain fully active at L1 (primitives) and L3 (foundations).

---

## What Is Subtracted

`Lint.Rule.Bundle.standards` equals `Lint.Rule.Bundle.institute` minus these two rules:

| Rule | Fires on |
|------|----------|
| `compound identifier` | Compound camelCase method / property names (`walkFiles` instead of `walk.files()`) |
| `compound type name` | Compound type names outside the `Nest.Name` pattern (`FileDirectoryWalk` instead of `File.Directory.Walk`) |

Every other institute-tier rule (which transitively includes the universal bundle) stays active — Foundation-import bans, typed-throws discipline, memory-safety rules, structural rules, and the remaining naming rules (`compound suite name`, `redundant prefix`, `nested tag`, …) all fire unchanged.

This is a **subtractive** bundle, not part of the additive `universal → institute → primitives` chain. The standards bundle is a sibling of `primitives`: both build on `institute`, but `standards` removes rules while `primitives` adds them.

---

## Quick Start

Activate the bundle by name in a lint configuration:

```swift
import Linter_Standards_Rules

let configuration = Lint.Configuration {
    Lint.Rule.Bundle.standards
}
```

In a package's `Lint.swift` (Shape γ):

```swift
import Linter
import Linter_Standards_Rules

Lint.run(dependencies: [
    .package(
        url: "https://github.com/swift-standards/swift-standards-linter-rules.git",
        branch: "main",
        products: ["Linter Standards Rules"]
    ),
]) {
    Lint.Rule.Bundle.standards
}
```

As the institute-tier bundle gains or loses rules, this bundle tracks it automatically — only the two named exclusions are ever removed. This repository lints itself with the same bundle — see [`Lint.swift`](Lint.swift).

---

## Installation

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swift-standards/swift-standards-linter-rules.git", branch: "main")
]
```

Add the product to your target:

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Linter Standards Rules", package: "swift-standards-linter-rules")
    ]
)
```

The package is pre-1.0 — depend on `branch: "main"` until `0.1.0` is tagged. Requires Swift 6.3 and macOS 26.

---

## Architecture

| Product | Contents | When to import |
|---------|----------|----------------|
| `Linter Standards Rules` | The aggregate — `Lint.Rule.Bundle.standards`, re-exporting the institute-tier bundle minus the two compound-naming rules | Standards-tier (L2) consumers |

---

## Related Packages

- [`swift-linter-primitives`](https://github.com/swift-primitives/swift-linter-primitives) — the `Lint.Rule` / `Lint.Rule.Configuration` vocabulary and the `excluding(rules:)` combinator this bundle is built with.
- [`swift-institute-linter-rules`](https://github.com/swift-foundations/swift-institute-linter-rules) — the institute-tier bundle this package subtracts from, and the leaf `Institute Linter Rule Naming` module that declares the two excluded rules.
- [`swift-primitives-linter-rules`](https://github.com/swift-primitives/swift-primitives-linter-rules) — the primitives-tier sibling bundle (`Lint.Rule.Bundle.primitives`, institute plus primitives-tier rules).

---

## Community

<!-- BEGIN: discussion -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
