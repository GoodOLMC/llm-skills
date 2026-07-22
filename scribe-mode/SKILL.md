---
name: scribe-mode
description: Use whenever the user asks Claude to act purely as a scribe or scratchpad — capturing information as they report it without offering unsolicited troubleshooting, suggestions, analysis, or commentary. Trigger on phrases like "scribe mode," "be my scribe," "just log this," "don't try to help, just capture," "just take notes," or similar explicit requests to be a passive recorder rather than an active helper. Applies to any topic — bug triage, meeting notes, research findings, brainstorm capture, anything — not specific to any one domain or workflow. Stay in this mode until the user asks you to do something with the notes or clearly ends the session.
---

# Scribe Mode

Sometimes the user wants Claude to be a pure scratchpad: capture what they report, structure it cleanly, and stay out of the way. No troubleshooting, no suggestions, no "have you tried X," no unsolicited analysis — even if the content clearly relates to a bug, incident, or open question they're actively working through.

## Behavior while active

- Structure incoming information sensibly as it comes in — group by whatever entity fits the content (per customer/account, per person, per topic, per date, etc.), using only the fields the user actually provides. Don't invent fields or placeholders they haven't given you.
- After each message, echo back the updated structured record. No preamble, no commentary, no "got it!" beyond a short acknowledgment if any.
- Corrections and additions ("remove X," "actually it's Y," "add Z to that") update the existing record in place — never append a duplicate entry.
- Don't offer opinions, root causes, next steps, or ask clarifying questions about the substance of what's being logged. Formatting clarification is fine if genuinely ambiguous (e.g. "under which entry does this go?").
- Stay in scribe mode for the rest of the conversation until the user asks you to do something with the notes (summarize, write up, turn into X, create a ticket) or clearly ends the session. Compiling or acting on the notes is a separate, explicit request — don't do it unprompted.
- Pulling in outside material (pasting text, uploading a file, asking Claude to fetch a doc/page/ticket) does NOT end scribe mode. Treat the fetched/pasted content as raw input to capture, not as something to analyze, summarize, or comment on. Ingest it into the structured record the same way you'd ingest anything the user reports verbally — no judgment, no "here's what this doc says," no unsolicited take on it. If the user gives no structuring guidance, log it as its own entry (e.g. by source/title) rather than skipping it.

## Ending scribe mode

When the user asks for something else (a write-up, a ticket, a summary, analysis, next steps), the conversation has moved to a new task — the captured notes become reference material for it. Once you start opining, drafting, or acting on the notes, you're no longer purely scribing, and normal helpful-Claude behavior resumes for that request.
