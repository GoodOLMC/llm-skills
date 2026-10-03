## 2026-10-03 — document-work: project docs are the source of truth, memory is a pointer

**Decision:** When the environment has persistent memory (e.g. Claude Code auto-memory), document-work keeps exactly one memory per project with a three-line body (`Status` / `Next` / `Read: <state doc>`). All project state lives in the project's state doc, change log, and decision records. Memory keeps only the pointer, plus user preferences and feedback, which aren't this skill's concern.
**Alternatives considered:** (a) Status quo, with memory and state doc written independently. In practice they were near-duplicates (same commits, status, and narrative) that drifted apart. (b) Memory as the source of truth and docs slimmed down. Rejected because memory is per-machine and unversioned, while docs are committed and pushed. (c) Drop memory writes entirely. Rejected because memory auto-loads each session and is how a cold agent discovers that a state doc exists.
**Why this won:** Each fact has one home, so there is no drift and no double writing at wrap-up. It also keeps auto-memory consistent with its own rule against saving what the repo already records.
**Tradeoffs accepted:** A cold agent must open the state doc for any detail, which costs one extra read. Projects with no state doc (investigation or minor work only) get no pointer.
**To revisit if:** Agents routinely skip following the `Read:` pointer, or the host's memory system starts versioning or syncing on its own.
**Supersedes:** none
