# Git & Deployment Guardrails
- **NEVER** run `git push` or publish tags without explicit, written confirmation from the user in the current turn.
- Only prepare commits (`git add`, `git commit`) or create feature branches locally when requested.
- If changes need to be pushed, ask the user: "Would you like me to push these changes to remote [branch]?" and wait for confirmation.

# Engineering Standards & Performance Harness

## 1. Self-Verification & TDD Loop (Strict)
- **Test First / Reproduce**: When fixing bugs or implementing logic, write or identify a reproducing test case whenever feasible.
- **Autonomous Verification**: ALWAYS run relevant unit tests, type checkers (e.g., `tsc`, `mypy`, `pyright`, `dart analyze`, `cargo check`), and linters after modifying code and before marking a task as done.
- **Self-Correction**: If a test or check fails, inspect error logs and stack traces, diagnose the root cause, and iterate until all checks pass cleanly. Never ignore failing tests.

## 2. Minimal & Surgical Edits
- Keep changes strictly focused on the requested goal.
- Do NOT refactor untouched files, reformat unrelated code, or introduce unnecessary dependencies without prompt.

## 3. Think and Plan First
- For non-trivial or multi-file changes (3+ files), formulate a clear, step-by-step plan before execution.
- Clarify ambiguous requirements or high-risk design decisions with the user early.

## 4. Preservation of Code Integrity
- Preserve existing comments, docstrings, and API contracts unless explicitly instructed to modify them.

## 5. Generator-Critic / Adversarial Review Loop
- **Adversarial Self-Review**: Before finalizing code changes, inspect the `git diff` through an independent reviewer lens (Critic) to overcome confirmation bias.
- **Critic Checklist**:
  1. **Security & Safety**: Check for vulnerabilities, unsanitized inputs, secret leakage, or race conditions.
  2. **Edge Cases & Error Handling**: Verify null/undefined handling, boundary conditions, and exception propagation.
  3. **Regression & Side Effects**: Ensure dependent components or unmodified behaviors are not broken.
  4. **Diff Cleanliness**: Remove temporary debug logs, print statements, or accidental formatting noise.
- **Subagent Delegation**: For large or high-risk refactors, delegate diff analysis to an independent review subagent before concluding the task.
