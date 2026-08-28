# Workspace Guidelines - AI Movie Studio

This file contains rules and guidelines for agents working in this repository. Follow these rules to avoid common environment difficulties.

---

## 1. PowerShell Variable Expansion in URLs
PowerShell parses double-quoted strings greedily. If a variable is immediately followed by a `?` (e.g., `"$fileName?key=$apiKey"`), PowerShell will interpret the variable name as `$fileName?key`, resulting in an empty expansion.
- **Rule:** Never use double-quoted variable expansion for URLs containing variables immediately followed by query parameters.
- **Solution:** Always use explicit string concatenation:
  ```powershell
  $statusUri = "https://generativelanguage.googleapis.com/v1beta/" + $fileName + "?key=" + $apiKey
  ```
  Or use explicit variable braces:
  ```powershell
  $statusUri = "https://generativelanguage.googleapis.com/v1beta/${fileName}?key=${apiKey}"
  ```

---

## 2. Gemini API Model Availability
Legacy models (such as `gemini-1.5-pro` or `gemini-2.5-pro`) are deprecated or restricted for new API keys in this environment, returning `404 Not Found` errors.
- **Rule:** For any generative content tasks, check active models first or use the recommended stable generation models.
- **Solution:** Use **`models/gemini-3.6-flash`** as the primary model for content and video analysis. Fallback to `models/gemini-3.7-flash` or `models/gemini-3.5-flash` if needed.

---

## 3. Handling Transient API Errors (503 / 429)
The Gemini API may return transient `503 Server Unavailable` or `429 Rate Limit Exceeded` errors during high-volume requests (like video analysis).
- **Rule:** Any script or command invoking the Gemini API must implement a robust retry loop.
- **Solution:** Attempt the API call at least 3 times, sleeping 10–15 seconds between retries, and loop through fallback models if a specific model remains unavailable.

---

## 4. Repository Integrity & Validation
Modifying the registry (`Registry/SkillRegistry.json`) without verifying file exists breaks the repository validation.
- **Rule:** Every time a skill is added, deleted, or modified, run the local validation script to ensure schema and link compliance.
- **Verification Command:**
  ```powershell
  powershell -ExecutionPolicy Bypass -File "Tools/validate_registry.ps1"
  ```
  Ensure it exits with code 0 before completing a task.

---

## 5. Sandboxing & Command Approvals
The workspace environment requires manual user approval for any command run with `BypassSandbox: true` (e.g., commands requiring network access).
- **Rule:** Maximize standard sandbox mode (`BypassSandbox: false`) for all local operations (compilation, file searches, script execution, validation testing). Sandboxed commands run automatically without prompting the user.
- **Rule:** Separate network operations from local operations. Only run the specific command that requires network access (e.g., API calls, downloads) with `BypassSandbox: true`. Do not chain them with local commands.
- **Rule:** Optimize commands for user "Always Allow" prefix-matching in the IDE:
  - Avoid command substitutions (`$(...)`) and shell variable expansions (`$VAR`).
  - Avoid invoking target commands through wrapper or eval tools (`env`, `sudo`, `timeout`, `xargs`, `eval`).
  - Use the IDE tool's background execution parameters (`WaitMsBeforeAsync` / `IsDaemon`) instead of shell backgrounding (`&`).

---

## 6. Default Video Analysis Workflow (Master Prompt Integration)
When a video file path is provided along with start and end times, the agent must automatically run the video analysis following the **Filmmaking Knowledge Extraction** guidelines:

### A. Professional-Level Expertise
The analysis must be conducted from the perspective of an expert film analyst with professional-level knowledge across the following 21 domains:
- Film Direction
- Screenwriting
- Acting
- Facial Expressions & Micro-expressions
- Body Language
- Dialogue Writing & Language
- Voice Performance
- Cinematography & Camera Language
- Frame Composition
- Visual Design & Storytelling
- Lighting
- Color Palette
- Editing & Pacing
- Sound Design
- Background Score & Music
- Psychology
- Action & Fight Choreography
- Relationship Between Departments

### B. Video Verification & Boundaries
- **Verify Inputs:** Before running, verify that the video file exists, can be opened, and that the requested timestamps are valid.
- **Duration Check:** Determine the video's total duration and the exact duration being analyzed.
- **Strict Bounds:** Analyze only the portion beginning at `START_TIME` and ending at `END_TIME`. Do not analyze footage outside this range.
- **Error Handling:** If the file cannot be accessed or the requested time range is invalid, stop and report the problem rather than making assumptions or changing the range.

### C. The Central Objective
Reverse-engineer the filmmaking language contained in the footage. For every meaningful moment, analyze:
- What can be seen/heard, what changed, and when did it change?
- How did the actor perform it and how did the body communicate it?
- How was the camera positioned/moved and how was the shot composed?
- How was it lit and edited?
- What sounds and musical score cues are present?
- How does the dialogue work, and how do all these elements interact?
*The final knowledge should help the AI Movie Studio understand how to construct similar filmmaking techniques, not merely understand what happened in the scene.*

### D. Source of Truth Rules
- **No Outside Info:** The supplied video is the absolute and exclusive source of truth. Do not use internet searches, databases, reviews, scripts, fan discussions, other versions, or trailers.
- **No Assumptions:** Do not assume a character's thoughts, intentions, emotions, history, location, or circumstances unless explicitly established.
- **No Equipment Guesses:** Do not assume a particular camera, lens, lighting setup, or instrument unless it can be established from the footage.
- **Unobservable Data:** When something cannot be reliably determined from the footage, explicitly state: **`NOT OBSERVABLE`**.

### E. Analyze Filmmaking, Not Just the Story
- Look beyond shallow descriptions (e.g., "the character gets angry").
- Document the visible progression of facial expressions, physical posture changes, camera adjustments, editing relationships, music timing, and dialogue pauses.
- Preserve the sequence of filmmaking decisions observable in the footage.

### F. Department-Specific Guidelines
1. **Acting & Human Performance:**
   - Describe physical evidence precisely instead of using broad emotional labels.
   - Observe eyes, eyebrows, eyelids, forehead, cheeks, mouth, jaw, and gaze direction.
   - Capture micro-expressions (brief glances, lip tightening, fleeting smiles).
   - Document body posture, shoulders, gestures, weight shifts, and spatial blocking.
   - Document performance changes as: **`BEFORE → OBSERVABLE CHANGE → AFTER`**.
2. **Dialogue, Screenwriting & Language:**
   - Capture the actual words spoken verbatim (preserve original language and wording). Use `[inaudible]` for unintelligible parts.
   - Analyze sentence length, word choice, rhythm, pauses, repetitions, silence, slang, idioms, formal/informal speech, and character vocabulary.
   - Extract language-specific dialogue patterns.
3. **Voice Performance:**
   - Observe pitch, volume, speed, rhythm, emphasis, pauses, breathing, and vocal tension.
4. **Camera Language & Cinematography:**
   - Determine shot size, angle, height, framing, subject placement, screen direction, eyelines, negative space, and depth.
   - Track camera movement (pan, tilt, track, dolly, push-in, pull-out, zoom).
   - Track focus behavior (rack focus, depth of field, subject/background separation).
5. **Composition & Visual Design:**
   - Analyze how visual information is arranged, spatial relationships, and blocking changes.
6. **Lighting & Color:**
   - Observe light direction, key style (hard/soft), highlights, shadows, contrast, and color palette characteristics.
7. **Direction & Blocking:**
   - Observe spatial movement, character blocking, and how camera placement responds to blocking. Describe construction without claiming private intention.
8. **Visual Storytelling:**
   - Track visual information, reveals, visual clues, and information shown or withheld.
9. **Psychology Through Observable Behavior:**
   - Ground psychology in physical evidence. Separate interpretation using:
     - **`OBSERVABLE BEHAVIOR`**
     - **`POSSIBLE INTERPRETATION`**
10. **Editing & Rhythm:**
    - Record cuts, reaction timing, action timing, dialogue timing, continuity, match-on-action, and reaction shots.
11. **Sound Design:**
    - Listen for footsteps, ambient noise, objects, breathing, and diegetic vs. non-diegetic sounds. Note silence.
12. **Background Score & Music:**
    - Record score start/end, intensity, rhythm, tempo, melody, crescendos, decrescendos, and instrumentation.
13. **Action & Fight Choreography:**
    - Record positions, strike direction, blocks, dodges, falls, recovery, and sound synchronization.

### G. Relationship Between Departments
Analyze how departments work together at key moments:
- **`Performance + Expression + Body Language + Dialogue + Voice + Blocking + Camera + Composition + Cinematography + Lighting + Color + Editing + Sound + Background Score + Rhythm`**

### H. Timestamped Evidence Format
Anchor important observations using:
```text
Timestamp:
Category:
Observation:
Analysis:
Confidence: [HIGH | MEDIUM | LOW | NOT OBSERVABLE]
```

### I. Repository Integration & Validation
After completing the analysis, extract transferable filmmaking knowledge and execute the `Prompts/MasterPrompt.md` workflow:
1. Verify the correct video was analyzed within the exact timeframe.
2. Ensure the video was the only evidence source.
3. Remove unsupported assumptions.
4. Ensure observations are timestamped and follow the structured block format.
5. Validate the repository against JSON schemas and ensure the registry is updated.
6. Run the local verification command:
   ```powershell
   powershell -ExecutionPolicy Bypass -File "Tools/validate_registry.ps1"
   ```

### J. Final Review Format
The final review report must clearly segregate and label:
- **`OBSERVED FACT`**
- **`FILMMAKING ANALYSIS`**
- **`POSSIBLE INTERPRETATION`**

