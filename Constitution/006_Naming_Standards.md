# AI Movie Skills Repository

## Constitution

# 006 — Naming Standards

**Version:** 1.0.0  
**Status:** Active  
**Last Updated:** 2026-08-03

---

# Purpose

This document defines the permanent naming standards for the AI Movie Skills Repository.

Consistent naming improves readability, discoverability, automation, validation, and long-term maintainability.

Every identifier, file, folder, tag, and metadata field within the repository must comply with these standards.

---

# Naming Philosophy

Names should be:

- Clear
- Stable
- Predictable
- Human-readable
- Machine-readable
- Technology-independent

A name should communicate intent without requiring additional explanation.

Avoid abbreviations unless they are standardized within the repository.

---

# Repository Naming

Repository names should:

- describe responsibility
- remain technology independent
- avoid implementation details
- avoid version numbers

Preferred examples:

```
ai-movie-skills
```

Avoid names tied to:

- AI providers
- programming languages
- frameworks
- runtime implementations

---

# Folder Naming

Folders represent knowledge domains or repository responsibilities.

Folder names must:

- use PascalCase
- avoid spaces
- avoid special characters
- remain singular when describing a concept

Examples:

```
Knowledge
Registry
Templates
Schemas
Constitution
```

Knowledge domains:

```
Acting
Camera
Dialogue
Lighting
Music
Psychology
Editing
Storytelling
Voice
FilmTheory
HumanBehaviour
VisualLanguage
```

---

# File Naming

Markdown skill files should follow:

```
<ID>_<DescriptiveName>.md
```

Example:

```
ACT_0001_ControlledThreat.md

CAM_0018_SlowPushIn.md

PSY_0025_InternalConflict.md
```

The descriptive name should:

- summarize the principle
- avoid unnecessary words
- remain concise
- use PascalCase

---

# Constitution Documents

Constitution documents use ordered numeric prefixes.

Example:

```
000_Vision.md

001_Mission.md

002_Knowledge_Philosophy.md
```

Reading order must never depend on alphabetical sorting.

---

# Template Files

Templates use PascalCase.

Examples:

```
SkillTemplate.md

KnowledgeTemplate.md

ReviewTemplate.md

MetadataTemplate.md
```

Template names should describe their purpose.

---

# Skill Identifiers

Every skill receives one permanent identifier.

Identifiers must never change.

Identifiers must never be reused.

General format:

```
<DOMAIN>_<NUMBER>
```

Examples:

```
ACT_0001

CAM_0008

PSY_0017

DIA_0005

LGT_0004

VOI_0012

MUS_0003

SND_0007

EDT_0011

STY_0009
```

Numeric portions should be sequential within each domain.

Deleted identifiers are never reassigned.

---

# Metadata Fields

Metadata keys should use:

```
camelCase
```

Examples:

```
skillId

relatedSkills

confidenceScore

createdDate

lastUpdated
```

Avoid unnecessary abbreviations.

---

# Tags

Tags classify concepts.

Tags are not categories.

Tags should:

- be lowercase
- use singular nouns
- avoid spaces
- use hyphens when necessary

Examples:

```
anger

fear

eye-contact

dominance

romance

leadership

micro-expression
```

Tags should describe concepts rather than implementations.

---

# Classification Stability

Repository classification evolves at different rates.

The following stability hierarchy applies.

| Artifact | Stability |
| -------- | --------- |
| Skill ID | Permanent |
| Category | Stable    |
| Tags     | Flexible  |

Definitions:

- **Skill IDs** establish permanent identity and must never change.
- **Categories** define long-term knowledge domains and should change only when repository architecture evolves.
- **Tags** describe searchable characteristics and may evolve as repository understanding improves.

Repository evolution should primarily occur through refining tags rather than changing categories or identifiers.

---

# Categories

Categories represent permanent knowledge domains.

Examples:

```
Acting

Camera

Dialogue

Psychology

Lighting

Music

Editing

Storytelling
```

Categories should change rarely.

Tags evolve more frequently.

---

# Relationship Names

Relationship names should be descriptive.

Preferred relationships include:

```
related

prerequisite

variation

refines

extends

opposite

complements
```

Avoid ambiguous relationship names.

---

# Version Numbers

Repository artifacts follow Semantic Versioning.

Examples:

```
1.0.0

1.1.0

2.0.0
```

Versioning rules are defined in the Versioning Standards.

---

# Reserved Prefixes

The following prefixes are reserved.

```
ACT

CAM

PSY

DIA

VOI

LGT

MUS

SND

EDT

STY
```

New prefixes require architectural approval.

---

# Naming Consistency

Names should remain stable over time.

Renaming should occur only when it significantly improves clarity.

Avoid unnecessary renaming.

Repository stability is more valuable than cosmetic improvements.

---

# Final Principle

Good names reduce ambiguity.

A contributor or AI system should understand the purpose of a repository artifact from its name alone.

Every naming decision should improve clarity, consistency, and long-term maintainability.
