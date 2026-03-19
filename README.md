# Agent Workflow Repo

This repository contains minimal configuration and guidance files for an agent-based planning and verification workflow. It defines lightweight instructions for planners and workers, along with per-tool settings for Claude and Codex.

## Repository Structure

- `AGENTS.md`: Repository-level working rules, including scope, restrictions, and change expectations.
- `CLAUDE.md`: Planner and verifier style guidance focused on short, executable output and strict review against acceptance criteria.
- `.claude/settings.json`: Claude-specific workflow configuration.
- `.codex/config.toml`: Codex-specific model, approval, and sandbox configuration.
