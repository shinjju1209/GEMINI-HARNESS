#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.gemini/config"

echo "📦 Installing Gemini Agent Harness..."
mkdir -p "${TARGET_DIR}"

cp "${SCRIPT_DIR}/GEMINI.md" "${TARGET_DIR}/GEMINI.md"
cp "${SCRIPT_DIR}/AGENTS.md" "${TARGET_DIR}/AGENTS.md"

echo "✅ Successfully installed Gemini Harness to ${TARGET_DIR}!"
echo "   - Global GEMINI.md: ${TARGET_DIR}/GEMINI.md"
echo "   - Global AGENTS.md: ${TARGET_DIR}/AGENTS.md"
