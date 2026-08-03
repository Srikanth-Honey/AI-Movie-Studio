# AI Movie Skills Repository

## Constitution

# 008 — Git Workflow

**Version:** 1.0.0
**Status:** Active
**Last Updated:** 2026-08-03

---

# Purpose

This document defines the official Git workflow for the AI Movie Skills Repository.

The workflow ensures that repository evolution remains traceable, reviewable, and reversible.

Every repository change must follow this workflow.

---

# Workflow Philosophy

The Git history represents the evolution of repository knowledge.

Every commit should explain **why** the repository became better.

Git history is part of the repository's permanent documentation.

---

# Branching Strategy

The default branch represents stable repository knowledge.

It must always remain deployable and internally consistent.

Direct commits to the default branch are prohibited.

All work must be performed on feature branches.

---

# Feature Branches

Every logical change must be developed in its own branch.

Examples:

```
feature/new-acting-skills

feature/update-camera-skills

feature/refine-review-standards

feature/improve-psychology-skills

feature/repository-maintenance
```

A branch should represent one logical objective.

Avoid mixing unrelated changes.

---

# Commit Standards

Each commit should represent one meaningful improvement.

Commit messages should clearly describe:

- what changed
- why it changed

Examples:

```
Add new reusable acting skill for controlled hesitation

Improve psychology skill explaining emotional suppression

Refine repository naming standards
```

Avoid vague commit messages.

Examples to avoid:

```
Update

Fix

Changes

Misc
```

---

# Pull Requests

Every branch should be merged through a Pull Request.

A Pull Request should contain:

- objective
- summary of changes
- architectural impact
- repository impact
- review notes

The Pull Request exists to improve repository quality rather than simply approve code.

---

# Review Requirements

Every Pull Request should verify:

- Constitution compliance
- Repository Standards compliance
- Naming Standards compliance
- Quality Standards compliance
- Skill Creation Standards compliance

Repository quality takes precedence over development speed.

---

# Merge Strategy

Merge only after review.

Do not bypass review.

Prefer preserving meaningful Git history.

Repository evolution should remain understandable years later.

---

# Knowledge Changes

Every knowledge modification should explain:

- why the change is needed
- what repository problem it solves
- why existing knowledge was insufficient
- expected long-term benefit

Knowledge evolution should always be intentional.

---

# Repository Maintenance

Repository maintenance changes should be isolated from knowledge changes whenever practical.

Examples include:

- documentation improvements
- schema updates
- template improvements
- tooling improvements

Avoid mixing maintenance with skill additions.

---

# Rollback

Every change should be reversible through Git history.

Repository history should remain sufficiently clear that previous repository states can be restored without ambiguity.

---

# AI Contributor Responsibilities

AI systems contributing to the repository should:

- create focused branches
- minimize unrelated changes
- preserve repository consistency
- explain architectural decisions
- recommend improvements when appropriate

AI systems assist repository evolution.

Human reviewers approve repository evolution.

---

# Final Principle

Every commit should improve the repository.

Every branch should have one purpose.

Every Pull Request should make the repository more valuable than it was before.
