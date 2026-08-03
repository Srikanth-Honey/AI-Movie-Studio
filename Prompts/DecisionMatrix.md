# Repository Decision Matrix

**Version:** 1.0.0

---

# Purpose

The Repository Decision Matrix defines how extracted filmmaking principles affect the repository.

It provides a deterministic decision process that ensures repository quality improves while minimizing unnecessary repository growth.

Every extracted principle must result in exactly one repository decision.

---

# Decision Priority

Evaluate repository decisions in the following order.

Never skip a higher-priority decision.

```
Reuse
    ↓
Improve
    ↓
Create Variant
    ↓
Merge
    ↓
Split
    ↓
Create New
    ↓
Reject
```

The first applicable decision is the correct decision.

---

# Decision Matrix

| Decision       | When to Select                                                   | Repository Action          |
| -------------- | ---------------------------------------------------------------- | -------------------------- |
| Reuse          | Existing knowledge already explains the principle completely     | No repository change       |
| Improve        | Existing knowledge can be strengthened                           | Update existing skill      |
| Create Variant | Existing principle exists but meaningful variation is discovered | Create linked skill        |
| Merge          | Multiple skills represent substantially the same principle       | Consolidate skills         |
| Split          | One skill contains multiple reusable principles                  | Create focused skills      |
| Create New     | Repository lacks the reusable principle                          | Create new skill           |
| Reject         | Knowledge is not reusable or does not improve repository quality | No repository modification |

---

# Decision Rules

## Reuse

Preferred whenever existing knowledge already solves the problem.

Avoid unnecessary repository growth.

---

## Improve

Preferred over creating new skills.

Strengthen repository quality.

Preserve existing identifiers.

---

## Create Variant

Only when:

- psychological objective differs
- cinematic purpose differs
- reusable application differs

Variants should inherit relationships from their parent skill.

---

## Merge

Merge only when repository duplication is reduced.

Never lose information.

Preserve repository history.

---

## Split

Split only when independent reusable principles exist.

Avoid unnecessary fragmentation.

---

## Create New

Only when all previous decisions are invalid.

A new skill must:

- improve repository coverage
- be reusable
- be timeless
- be explainable
- satisfy repository quality standards

---

## Reject

Reject when knowledge is:

- actor-specific
- movie-specific
- scene-specific
- speculative
- duplicated
- unsupported
- implementation-specific

Repository quality is more important than repository size.

---

# Repository Principle

The objective is not to maximize the number of skills.

The objective is to maximize repository intelligence.

Every accepted repository change should leave the repository stronger than before.
