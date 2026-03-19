# Agent Factory Repo

This repository contains a minimal configuration scaffold for an agent workflow. It includes guidance for planner and verifier behavior, shared repository constraints for agents, and tool-specific configuration for Codex and Claude.

## Repository Structure

- `AGENTS.md`: Repository-wide working rules, scope limits, and expectations for changes.
- `CLAUDE.md`: Planner and verifier guidance focused on short, executable plans and strict acceptance review.
- `.codex/config.toml`: Codex model, approval, and sandbox configuration.
- `.claude/settings.json`: Claude model selection and notes for the agent workflow.
