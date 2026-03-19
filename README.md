# Agent Factory Test Repository

This repository is a minimal test fixture for an agent workflow. It contains planner and verifier guidance plus tool-specific configuration for Codex and Claude, and is intended to keep agent tasks small, direct, and easy to review.

## Repository Structure

- `AGENTS.md`: Repository-level instructions for scoped changes, restrictions, and verification expectations.
- `CLAUDE.md`: Planner and verifier guidance, including expectations for concise plans and strict review against acceptance criteria.
- `.codex/config.toml`: Codex configuration used by the repository.
- `.claude/settings.json`: Claude settings for the planner/verifier workflow.

