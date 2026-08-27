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

import Institute_Linter_Rule_Naming
import Linter_Institute_Rules
import Linter
import Linter_Standards_Rules
import Testing

extension Lint.Rule.Bundle {
    @Suite
    struct `standards Tests` {
        @Suite struct Unit {}
        @Suite struct `Edge Case` {}
        @Suite struct Integration {}
    }
}

extension Lint.Rule.Bundle.`standards Tests` {
    /// The standards bundle removes EXACTLY the two compound-naming rules
    /// from the institute bundle — no more, no fewer.
    @Test func `subtracts exactly the two compound naming rules`() {
        let instituteIDs = Set(Lint.Rule.Bundle.institute.map(\.rule.id))
        let standardsIDs = Set(Lint.Rule.Bundle.standards.map(\.rule.id))
        let removed = instituteIDs.subtracting(standardsIDs)
        #expect(
            removed == [
                Lint.Rule.`compound identifier`.id,
                Lint.Rule.`compound type name`.id,
            ]
        )
    }

    /// The subtraction removes two entries — the count drops by exactly two.
    @Test func `count is institute minus two`() {
        #expect(Lint.Rule.Bundle.standards.count == Lint.Rule.Bundle.institute.count - 2)
    }

    /// Neither excluded rule survives in the standards bundle.
    @Test func `excluded rules are absent`() {
        let standardsIDs = Set(Lint.Rule.Bundle.standards.map(\.rule.id))
        #expect(!standardsIDs.contains(Lint.Rule.`compound identifier`.id))
        #expect(!standardsIDs.contains(Lint.Rule.`compound type name`.id))
    }

    /// Every other institute-tier rule is preserved unchanged.
    @Test func `all other institute rules are retained`() {
        let excluded: Set<Lint.Rule.ID> = [
            Lint.Rule.`compound identifier`.id,
            Lint.Rule.`compound type name`.id,
        ]
        let standardsIDs = Set(Lint.Rule.Bundle.standards.map(\.rule.id))
        for configuration in Lint.Rule.Bundle.institute
        where !excluded.contains(configuration.rule.id) {
            #expect(standardsIDs.contains(configuration.rule.id))
        }
    }
}
