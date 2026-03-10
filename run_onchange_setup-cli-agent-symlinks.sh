#!/bin/bash
set -e

mkdir -p ~/.claude/agents ~/.copilot/agents

ln -sf ~/.cli_agent/instructions.md ~/.claude/CLAUDE.md
ln -sf ~/.cli_agent/settings.json ~/.claude/settings.json
ln -sf ~/.cli_agent/agents/auto.agent.md ~/.claude/agents/auto.agent.md

ln -sf ~/.cli_agent/instructions.md ~/.copilot/copilot-instructions.md
ln -sf ~/.cli_agent/agents/auto.agent.md ~/.copilot/agents/auto.agent.md
