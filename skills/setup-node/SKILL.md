---
name: setup-node
description: Set up an opinionated TypeScript Node.js project in the current directory or a new named directory. Uses pnpm via corepack, strict tsconfig, eslint-config-agent, Prettier, Vitest, and git hooks. Use when initializing any Node.js service, CLI, or library — not Next.js (use new-project-nextjs for that).
argument-hint: "[project-name or blank for cwd]"
allowed-tools: Bash Read Write Edit
---

# Setup Node Project

## Resolve target

If `$ARGUMENTS` blank: work in current dir, use its name as project name.
If `$ARGUMENTS` given: create and enter `./$ARGUMENTS`.

## Prerequisites

Verify node and corepack are available. Stop if missing.
Enable pnpm via corepack: `corepack enable pnpm`.

## Initialize

If no `package.json`: scaffold with `pnpm create vitest@latest` — do NOT use `pnpm init` or `tsc --init`. Choose TypeScript + Node environment when prompted.

Install missing tooling with `pnpm add -D`: `tsx`, `@types/node`, `eslint`, `eslint-config-agent`, `prettier` — skip any already in devDependencies.

## Configure

For each file: create if missing, update if present but incomplete — never overwrite user customizations.

- **tsconfig.json** — strict TypeScript, NodeNext module resolution, ES2022 target, src → dist
- **eslint.config.js** — extend `eslint-config-agent` only, no custom rules
- **.prettierrc** — sensible defaults (100 width, trailing commas, double quotes)
- **.gitignore** — append `node_modules/`, `dist/`, `.env*` if not already excluded
- **.env.example** — add `NODE_ENV=development` if missing
- **.node-version** — write current node major only if missing

## Starter files

Create `src/index.ts` and `src/index.test.ts` only if they don't exist.

## Git hooks

Set up git hooks for pre-commit and pre-push quality checks.
Skip if hooks already configured.

## Verify

Run `pnpm typecheck`. Report errors but do not fail.

## Done

Output project name, dir, and key commands: `pnpm dev`, `pnpm test`, `pnpm typecheck`.
