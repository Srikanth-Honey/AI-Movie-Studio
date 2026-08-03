# AI Movie Skills Repository

## Constitution

# 005 — Repository Standards

**Version:** 1.0.0  
**Status:** Active  
**Last Updated:** 2026-08-03

---

# Purpose

This document defines the permanent structural standards of the AI Movie Skills Repository.

These standards ensure that the repository remains organized, maintainable, scalable, and consistent regardless of its size or the AI systems interacting with it.

Repository architecture should evolve slowly.

Knowledge should evolve continuously.

---

# Repository Philosophy

The repository is the permanent home of reusable filmmaking knowledge.

It is not:

- a movie project
- an asset library
- an AI runtime
- an automation platform
- a prompt collection
- a code repository

Every file should directly support reusable filmmaking knowledge.

---

# Single Responsibility Principle

Every folder has exactly one responsibility.

Every document has exactly one responsibility.

Every skill has exactly one purpose.

Responsibilities must never overlap.

When overlap is discovered, refactor the architecture rather than introducing duplication.

---

# Source of Truth

The repository is the authoritative source for all reusable filmmaking knowledge.

The repository should never depend upon generated artifacts.

Generated outputs are disposable.

Knowledge is permanent.

Whenever a conflict exists between generated content and repository knowledge, the repository always takes precedence.

---

# Repository Organization

The repository is organized into clearly separated domains.

Each top-level folder owns a single area of responsibility.

Examples include:

- Constitution
- Knowledge
- Registry
- Schemas
- Templates
- Tools

Do not introduce new top-level folders without architectural justification.

---

# Knowledge Organization

Knowledge is organized by filmmaking domains.

Domains exist to improve discoverability and maintainability.

Folders represent knowledge domains.

Markdown files represent individual reusable skills.

Never store multiple independent skills in one file.

---

# Repository Boundaries

The repository stores only reusable filmmaking knowledge.

The repository must never store:

- movie projects
- scripts
- character biographies
- production assets
- generated prompts
- generated videos
- generated audio
- runtime payloads
- temporary files
- implementation-specific artifacts

These belong in separate repositories or execution environments.

---

# Skill Ownership

Each skill has:

- one unique identifier
- one canonical file
- one canonical location

Duplicate copies are prohibited.

Alternative versions must evolve through versioning rather than duplication.

---

# Registry Standards

The Registry indexes repository knowledge.

The Registry is metadata only.

It must never duplicate the contents of knowledge files.

The Registry exists to support:

- discovery
- validation
- indexing
- relationship mapping

Knowledge files remain the source of truth.

---

# Schema Standards

Schemas define repository structure.

Schemas validate consistency.

Schemas do not define filmmaking knowledge.

Business logic belongs in the Constitution and knowledge files, not in schemas.

---

# Template Standards

Templates exist to improve consistency.

Templates should never replace repository standards.

Templates inherit their rules from the Constitution.

If a template conflicts with the Constitution, the Constitution takes precedence.

---

# Documentation Standards

Every major folder must contain a README.md describing:

- its purpose
- its responsibilities
- permitted contents
- prohibited contents

Documentation should describe intent rather than implementation.

---

# Repository Evolution

Repository structure should remain stable.

Architectural changes require strong justification.

Prefer extending existing structures over introducing new ones.

Avoid frequent structural changes.

Knowledge should grow.

Architecture should remain stable.

---

# Repository Integrity

Every change should preserve:

- consistency
- traceability
- readability
- maintainability
- scalability

No contribution should reduce repository quality.

---

# Repository Invariants

The following rules are permanent.

- Every skill has one permanent ID.
- IDs are never reused.
- Every skill exists in exactly one canonical location.
- Registry entries reference skills but never duplicate them.
- Repository structure remains technology-independent.
- Repository knowledge remains model-independent.
- Folder responsibilities do not overlap.
- The Constitution governs the entire repository.

These invariants should not be violated.

---

# Repository Success

The repository is successful when:

- contributors know exactly where new knowledge belongs
- duplicate knowledge becomes increasingly rare
- repository organization remains intuitive
- AI systems can reliably locate relevant knowledge
- long-term maintenance becomes easier rather than harder

---

# Final Principle

The repository is not merely a collection of files.

It is a structured knowledge system.

Every architectural decision should strengthen the repository's ability to preserve, organize, and evolve reusable filmmaking knowledge for decades to come.
