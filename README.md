# iohan_superpowers

Three personal Claude Code subagents that turn a single Claude session into a small, disciplined engineering team. They are **role definitions** (markdown + frontmatter), not code — Claude Code loads them as dispatchable subagents.

| Agent | Role | Model |
|---|---|---|
| `iohan-powers-orchestrator` | Holds the map, the budget, the quality bar — never holds the pen. Dispatches domain-matched implementers + fresh spec/quality reviewers per task, inspects ground truth personally. | `inherit` |
| `iohan-powers-creative-advisor` | Consultation-only design counsel. Converts desires into mechanisms, partitions trust, maps failure modes, cuts scope (YAGNI). Advises, never implements. | `opus` |
| `iohan-powers-debug-advisor` | Defect-localization counsel. Reproduces with production inputs, builds hypothesis trees, dispatches read-only inspector subagents. Diagnoses, never fixes. | `opus` |

The three compose: the **orchestrator** runs the show and calls the **creative-advisor** mid-design or the **debug-advisor** when a bug resists a first pass.

---

## Prerequisites

### 1. Claude Code

These agents only work inside [Claude Code](https://claude.com/claude-code), Anthropic's CLI.

```bash
# macOS / Linux
curl -fsSL https://claude.com/install.sh | bash

# or via npm (needs Node 18+)
npm install -g @anthropic-ai/claude-code
```

Verify:

```bash
claude --version
```

First run prompts for login (Anthropic account or API key).

### 2. Opus access

`creative-advisor` and `debug-advisor` pin `model: opus`. You need a plan/API key with Opus access (Claude Pro/Max, or Console API billing). Without it those two fall back or error. The orchestrator uses `inherit` (whatever your session runs), so it works on any model.

### 3. (Optional but recommended) superpowers skill suite

The orchestrator is built to run on the **superpowers** workflow skills (`brainstorming → writing-plans → using-git-worktrees → subagent-driven-development → requesting-code-review → finishing-a-development-branch`). It degrades gracefully if absent, but you get the full discipline only with them installed. See the [superpowers plugin](https://github.com/obra/superpowers).

---

## Install

Claude Code discovers subagents from `~/.claude/agents/` (user-global) or `<project>/.claude/agents/` (project-local).

### Option A — install script (user-global)

```bash
git clone https://github.com/IohanFaustino/iohan_superpowers.git
cd iohan_superpowers
./install.sh
```

### Option B — manual copy

```bash
mkdir -p ~/.claude/agents
cp agents/iohan-powers-*.md ~/.claude/agents/
```

### Option C — symlink (stay in sync with the repo)

```bash
mkdir -p ~/.claude/agents
for f in "$PWD"/agents/iohan-powers-*.md; do
  ln -sf "$f" ~/.claude/agents/
done
```

Verify Claude Code sees them:

```bash
claude
# then in-session:
/agents
```

You should see the three `iohan-powers-*` agents listed.

---

## Usage

In any Claude Code session:

- **"orchestrate this"** / **"be the orchestrator"** → dispatches `iohan-powers-orchestrator`.
- **"consult the creative advisor"** / design verdict → `iohan-powers-creative-advisor`.
- **"help me find this bug"** (after a first failed pass) → `iohan-powers-debug-advisor`.

Claude also auto-routes to them when a request matches their `description`. You don't have to name them explicitly.

---

## Updating

```bash
git pull
./install.sh   # re-copies; symlink users already in sync
```

## Layout

```
.
├── README.md
├── install.sh
└── agents/
    ├── iohan-powers-orchestrator.md
    ├── iohan-powers-creative-advisor.md
    └── iohan-powers-debug-advisor.md
```
