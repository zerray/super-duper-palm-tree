# Agent Workflow Config Repo

This repository contains minimal configuration and guidance files for an agent-driven workflow that uses planner, worker, and verifier style roles. It is intentionally small and centers on repository-level instructions plus tool-specific settings for Codex and Claude.

## Repository Structure

- `AGENTS.md`: Repository-wide constraints and expectations for agent work in this repo.
- `CLAUDE.md`: Planner and verifier guidance, including how reviews and plans should be scoped.
- `.codex/config.toml`: Codex configuration for model, approval policy, and sandbox behavior.
- `.claude/settings.json`: Claude settings for the agent workflow.
