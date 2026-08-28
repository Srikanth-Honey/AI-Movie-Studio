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
---

### F. MANDATORY DEPTH & QUANTITY REQUIREMENTS

These are non-negotiable minimums. If not met, the analysis is incomplete.

1. **Minimum 40 timestamped observation blocks** for any clip between 1–3 minutes. Scale proportionally for longer clips (minimum 15 blocks per minute of footage).
2. **Every 5–10 seconds of footage must have at least one dedicated observation block.** Do not skip or consolidate moments.
3. **Every block must cover at minimum 2 domains simultaneously.** No single-domain blocks allowed.
4. **Total response must be at minimum 4000 words.** Shorter responses indicate insufficient depth.
5. **Every block must include a minimum 3-sentence Observation and 2-sentence Analysis.**
6. **maxOutputTokens must be set to 8192** in every API call for video analysis.
7. **temperature must be set to 0.1** (not default) for maximum factual precision.

---

### G. Department-Specific Guidelines (Expanded)

#### 1. Acting & Human Performance — MANDATORY ANATOMY
For every acting moment, document ALL of the following physical zones, not just general impression:

**Face Anatomy (document each zone separately):**
- **Eyes:** Pupil direction, eyelid openness (wide/half/narrowed/closed), blink rate change, moisture/tears, squinting
- **Eyebrows:** Position (raised/neutral/furrowed/asymmetric), tension level, inner/outer corner direction
- **Forehead:** Wrinkling (none/minimal/deep), tension bands, directional creases
- **Cheeks:** Raised/flat, flush visible, muscle tension
- **Nose:** Nostril flare, bridge tension
- **Mouth:** Corner direction (up/down/neutral), lip compression/parting, jaw tension, teeth visible/hidden, lip tremor
- **Jaw:** Clenched/relaxed, set direction (forward/back), grinding observable

**Micro-expressions (mandatory to capture):**
- Any expression lasting less than 1 second that contradicts the dominant expression
- Fleeting smiles before returning to neutral
- Brief eye drops before sustained eye contact
- Momentary lip tightening before speaking

**Emotion Construction (replace broad labels with physical evidence):**
- ❌ WRONG: "The actor looks angry"
- ✅ CORRECT: "BEFORE → neutral brow, relaxed jaw, soft eye contact → OBSERVABLE CHANGE → inner brows descend and compress together, jaw muscles visibly tighten, eyelids narrow to approximately 60% open, gaze hardens with no blink → AFTER → sustained locked gaze, shoulders rolled forward, chin slightly lowered"

**Emotion Categories (each requires specific physical evidence, not labels):**

*ANGER:* Brow compression toward center, jaw set forward or clenched, eye narrowing, nostril flare, neck muscle tension, shoulders forward, voice speed increases, volume rises, jaw muscles visible

*COMEDY/HUMOR:* Cheek raise, eye crinkling (orbicularis oculi activation), asymmetric mouth raise, brief head tilt, relaxed shoulders, voice pitch rises slightly, timing pause before punchline, body leans back or turns away before delivering the line

*THREAT/INTIMIDATION:* Sustained unbroken eye contact, minimal blinking, deliberate slowing of movement, lowered chin, voice drops in pitch and volume (not rises), stillness in body, spatial approach toward target

*GRIEF/SADNESS:* Inner eyebrow raise (corrugator supercilii), lip corners pull down, chin dimpling, eyes moistening or unfocused, shoulders cave inward, vocal tremor, head drops forward

*REVERENCE/AWE:* Eyes widen and soften, head tilts slightly back, jaw relaxes and lips part slightly, body becomes still, breathing observable as deeper, voice becomes slower and quieter, body may open or turn toward the subject

*FEAR:* Whites of eyes more visible (upper eyelid raises), eyebrows raise and pull together, upper lip may raise, body braces or freezes, breathing may become shallower/faster, shoulders raise toward ears

*SKEPTICISM/DOUBT:* Single eyebrow raise OR brow furrow with chin forward, slight head tilt, lips pressed together, arms may cross, weight shifts back

*JOY/HAPPINESS:* Both cheeks raise (Duchenne marker — genuine vs. social), eyes crinkle at outer corners, full smile with teeth, body opens and leans forward, voice brightens in quality

*RESOLVE/DETERMINATION:* Jaw sets, brow lowers centrally, eyes fix on a point, shoulders square, breath held or measured, voice becomes flat and even

*SURPRISE:* Eyebrows shoot upward, eyes open maximally, jaw drops or mouth opens, body may lean back, sharp intake of breath audible

#### 2. Fight & Action Choreography — MANDATORY SEQUENCE FORMAT

For every fight/action moment, document the full sequence using this format:

```
POSITION_START: [distance between parties, stance, guard, spatial orientation]
ACTION_1: [who / what move / direction / target zone / observable speed]
REACTION_1: [who / what defensive response / evasion direction / success or impact]
IMPACT: [contact visible or cut-away / sound timing relative to visual / body response]
RECOVERY: [time / repositioning / fatigue signals]
POSITION_END: [distance, stance, spatial change from start]
SOUND_SYNC: [impact sound before/simultaneous/after the visual]
```

Additionally note:
- Opening position of all parties (distance, angle, stance width, weight distribution, guard position)
- Weapon type and observable handling technique
- Spatial distance changes (closing / maintaining / creating distance)
- Group dynamics: who attacks whom, in what sequence
- Terrain usage: obstacles, elevation, surface effects

#### 3. Dialogue, Screenwriting & Language
- Capture **every word spoken verbatim**. Preserve original language (Telugu, Hindi, Tamil, English) exactly as spoken. Use `[inaudible]` for unintelligible parts. Never paraphrase.
- Note: sentence length, word rhythm, pauses (duration in seconds if measurable), repetitions, silence
- Note: code-switching between languages — which word/phrase triggers the switch and why
- Note: when silence replaces expected dialogue and what that silence communicates

#### 4. Voice Performance
- **Pitch:** Baseline and deviation (higher/lower, relatively)
- **Volume:** Baseline and deviation. Is increase from chest, throat, or diaphragm observable?
- **Speed:** Slow / medium / fast / very fast. Changes mid-sentence?
- **Rhythm:** Even / conversational / staccato / legato
- **Emphasis:** Which specific words receive emphasis, and what type (volume/pitch/pause/elongation)
- **Pauses:** Location (before/at/after punctuation). Duration (beat/half-second/full second/extended)
- **Breathing:** Audible? Shallow or deep? Mid-sentence or between sentences?
- **Vocal Tension:** Tight/constricted vs. open/resonant. Tremor present?
- **Vocal Quality:** Warm/cold, resonant/thin, breathy/pressed

#### 5. Camera Language & Cinematography
- **Shot Size:** ECU / CU / MCU / MS / MLS / LS / WS / EWS
- **Camera Angle:** Low angle / eye level / high angle / bird's eye / dutch tilt
- **Subject Placement:** Left-third / center / right-third; upper / mid / lower frame
- **Eyeline:** Screen-left / screen-right / into lens / down / up / away
- **Depth of Field:** Deep / shallow / rack focus event (describe what shifted)
- **Camera Movement:** Static / push-in / pull-out / pan / tilt / tracking / dolly / handheld / crane
- **Lens Behavior:** Wide-angle distortion / telephoto compression / fisheye?

#### 6. Composition & Visual Design
- Rule of thirds adherence or deliberate violation
- Symmetry or asymmetry (which side is heavier)
- Leading lines direction
- Foreground / midground / background — what occupies each layer?
- Frame-within-frame compositions (doors, windows, arches, bars)
- Color contrast between subject and background

#### 7. Lighting & Color
- **Key light direction:** Screen-left / screen-right / front-on / back-lit / top-lit / under-lit
- **Key light quality:** Hard (sharp shadow edges) / soft (gradual falloff)
- **Shadow placement and hardness on face**
- **Catchlights:** Present in eyes? Position?
- **Fill ratio:** Low contrast (heavy fill) / high contrast Rembrandt-style (minimal fill)
- **Overall luminosity:** High-key / mid-key / low-key
- **Color temperature:** Warm (amber) / neutral / cool (blue)
- **Dominant color palette:** List 2–3 hues

#### 8. Editing & Pacing
- Shot duration estimate in seconds
- Cut type: hard cut / dissolve / match-on-action / J-cut / L-cut / smash cut
- Cut timing relative to dialogue: mid-sentence / end / before / during pause
- Cut timing relative to music: on the beat / between beats / on musical accent
- Continuity: spatial continuity maintained / axis crossed

#### 9. Sound Design
- List **every audible sound** separately with source identification
- Footsteps (surface type), clothing, props, breathing, ambient room tone, environmental
- Diegetic (within scene world) vs. non-diegetic (added in post)
- Silence events: when, duration, what it replaces

#### 10. Background Score & Music
- **Exact timestamp** when score enters and exits
- **Tempo:** Slow / medium / fast (BPM estimate if possible)
- **Instrumentation:** Strings / brass / choir / percussion / solo instrument
- **Melodic direction:** Rising / falling / static
- **Dynamics:** pianissimo → fortissimo range used
- **Crescendo/decrescendo events:** timestamp + duration
- **Score-to-dialogue alignment:** Does music rise when dialogue pauses?
- **Score-to-cut alignment:** Musical accent on cut?

#### 11. Psychology Through Observable Behavior
Always use this format:
- **`OBSERVABLE BEHAVIOR:`** [exact physical description only]
- **`POSSIBLE INTERPRETATION:`** [one reading, clearly labeled]

---

### H. MULTI-CATEGORY BLOCK RULE (Critical)

**A single timestamp MUST produce multiple observation blocks — one per domain cluster.**

The same 3-second moment requires separate blocks for each:
- Block A: Acting + Facial Expressions + Micro-expressions
- Block B: Camera + Composition + Lighting
- Block C: Dialogue + Voice Performance
- Block D: Editing + Sound Design
- Block E: Psychology + Body Language
- Block F: Background Score + Music (if present)

**Never collapse multiple domains into a single block when they contain meaningfully different observations.** The purpose of separate blocks is to make each domain's technique independently extractable as a reusable filmmaking skill.

---

### I. API Call Requirements for Video Analysis

**Use the inline base64 approach** (the File API upload endpoint is blocked in this environment):

```powershell
# Read and encode video
$fileBytes = [System.IO.File]::ReadAllBytes($videoPath)
$base64 = [Convert]::ToBase64String($fileBytes)

# Build request with MANDATORY config
$requestBody = @{
    contents = @(@{
        role = "user"
        parts = @(
            @{ inline_data = @{ mime_type = "video/mp4"; data = $base64 } },
            @{ text = $prompt }
        )
    })
    generationConfig = @{
        temperature = 0.1
        maxOutputTokens = 8192
    }
} | ConvertTo-Json -Depth 10

# Model priority — try in order, auto-fallback on 404
$models = @("gemini-3.6-flash", "gemini-3.7-flash")
```

**Retry loop is mandatory:** 3 attempts per model, 15-second sleep between retries, auto-advance to next model on 404.

**Progress logging is mandatory:** Write timestamped entries to a `progress.log` file at every major step.

---

### J. Timestamped Evidence Format

Every observation block uses this EXACT format:

```text
---
Timestamp: [HH:MM:SS – HH:MM:SS]
Category: [Domain Name(s) — list all that apply to this block]
Observation: [Minimum 3 sentences. Physical, observable evidence only. No interpretations.]
Analysis: [Minimum 2 sentences. Filmmaking technique explanation.]
Confidence: [HIGH | MEDIUM | LOW | NOT OBSERVABLE]
---
```

**Multiple blocks for the same timestamp are expected and required.**

---

### K. Repository Integration & Approval Gate

After completing the video analysis and before starting the `Prompts/MasterPrompt.md` repository workflow:

1. **Present Analysis:** Show the complete timestamped evidence and Final Review to the user.
2. **Request Approval:** STOP. Wait for the user's **explicit written approval** before modifying any repository files.
3. **Execute (only after approval):**
   a. Verify the correct video was analyzed within the exact timeframe.
   b. Ensure the video was the only evidence source.
   c. Remove unsupported assumptions.
   d. Ensure observations are timestamped and follow the structured block format.
   e. Validate the repository against JSON schemas and ensure the registry is updated.
   f. Run the local verification command:
      ```powershell
      powershell -ExecutionPolicy Bypass -File "Tools/validate_registry.ps1"
      ```
   g. Confirm exit code 0 before marking the task complete.

---

### L. Final Review Format

The final review report must contain ALL of the following labeled sections:

- **`OBSERVED FACTS:`** Bullet list — directly observable facts only
- **`FILMMAKING ANALYSIS:`** Bullet list — technique-level observations
- **`POSSIBLE INTERPRETATIONS:`** Bullet list — clearly labeled as interpretations only
- **`DEPARTMENT SYNERGY MOMENTS:`** 3–5 key moments where multiple departments worked in perfect coordination, naming all departments involved
- **`EMOTION CONSTRUCTION SUMMARY:`** For each major emotion visible — list the exact physical evidence that constructed it (not just the label). Format: `EMOTION → physical evidence list`
- **`REUSABLE FILMMAKING PRINCIPLES OBSERVED:`** 5–10 generalizable, timeless principles applicable to other productions (these become skill candidates for the MasterPrompt workflow)
