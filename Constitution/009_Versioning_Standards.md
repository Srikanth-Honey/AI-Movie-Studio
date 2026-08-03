# AI Movie Skills Repository

## Constitution

# 009 — Versioning Standards

**Version:** 1.0.0
**Status:** Active
**Last Updated:** 2026-08-03

---

# Purpose

This document defines the permanent versioning standards for the AI Movie Skills Repository.

Versioning ensures that repository knowledge evolves in a controlled, traceable, and understandable manner while preserving historical context.

Knowledge should improve continuously without sacrificing stability.

---

# Versioning Philosophy

Knowledge is expected to evolve.

Repository history should preserve that evolution.

Versioning exists to communicate the significance of change.

Version numbers should describe repository evolution rather than repository age.

Every version should represent a measurable improvement.

---

# Scope

Versioning applies to:

- Constitution documents
- Repository standards
- Templates
- Schemas
- Registry format
- Individual skills

Versioning does not apply to:

- Git commits
- Feature branches
- Pull Requests

Git history already provides those capabilities.

---

# Semantic Versioning

Repository artifacts follow Semantic Versioning.

```
MAJOR.MINOR.PATCH
```

Example:

```
1.0.0
```

---

# Major Version

Increase the major version when introducing changes that fundamentally alter repository behavior or compatibility.

Examples include:

- constitutional changes
- repository architecture redesign
- skill structure redesign
- incompatible schema changes

Major versions should occur rarely.

---

# Minor Version

Increase the minor version when introducing meaningful improvements while maintaining compatibility.

Examples include:

- expanding explanations
- improving repository standards
- adding optional metadata
- strengthening documentation
- improving relationships

Minor versions represent normal repository evolution.

---

# Patch Version

Increase the patch version for corrections that do not change repository behavior.

Examples include:

- spelling corrections
- grammar improvements
- formatting
- clarification
- documentation fixes

Patch releases should never change repository intent.

---

# Skill Versioning

Every skill maintains its own independent version.

Skill versions evolve separately from repository versions.

Example:

```
Repository

Version 1.3.0

↓

ACT_0045

Version 2.1.0
```

Repository evolution and knowledge evolution are independent.

---

# Updating Existing Skills

Prefer improving existing skills over creating new ones.

Typical improvements include:

- better explanations
- improved psychology
- clearer examples
- stronger relationships
- additional guidance

Improvement is the preferred form of repository growth.

---

# Breaking Skill Changes

Increase the major version of a skill when:

- the underlying principle changes
- previous guidance becomes incorrect
- interpretation fundamentally changes

Major skill revisions should preserve historical traceability.

---

# Non-Breaking Skill Changes

Increase the minor version when:

- explanations improve
- relationships expand
- metadata improves
- clarity increases

The underlying principle remains unchanged.

---

# Editorial Changes

Increase the patch version when:

- formatting improves
- spelling corrections occur
- wording becomes clearer

No repository behavior changes.

---

# Deprecation

Knowledge should rarely be deleted.

Instead:

Mark it as deprecated.

Deprecation indicates:

- historical value remains
- newer knowledge exists
- future work should use the replacement

Deprecated knowledge remains part of repository history.

---

# Skill Identifiers

Skill identifiers are permanent.

Rules:

- IDs never change.
- IDs are never reused.
- IDs remain valid after deprecation.
- Version numbers evolve.
- IDs do not.

Identity and version are separate concepts.

---

# Repository Evolution

Repository architecture should evolve slowly.

Knowledge should evolve continuously.

Changes should prioritize:

- stability
- compatibility
- maintainability
- clarity

Avoid architectural churn.

---

# Change Documentation

Every version increase should document:

- what changed
- why it changed
- expected repository impact

Repository history should explain repository evolution.

---

# Backward Compatibility

Whenever practical:

- preserve compatibility
- avoid unnecessary structural changes
- evolve through refinement rather than replacement

Breaking changes require clear justification.

---

# Historical Traceability

Previous versions should remain understandable.

Repository history should explain:

- what changed
- why it changed
- how repository understanding improved

History is part of repository knowledge.

---

# Continuous Evolution

Versioning should encourage improvement rather than discourage change.

The objective is not to preserve outdated knowledge.

The objective is to preserve the history of learning.

Knowledge becomes stronger through disciplined evolution.

---

# Final Principle

The repository should continuously improve while remaining stable, understandable, and trustworthy.

Version numbers communicate the evolution of understanding.

They should always reflect meaningful improvements to the repository and its knowledge.
