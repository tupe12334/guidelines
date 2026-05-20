---
name: setup-rust
description: Set up an opinionated Rust project in the current directory or a new named directory. Configures Cargo with common deps via cargo add, rustfmt, clippy, rust-toolchain, and git hooks. Use when initializing any Rust binary, library, or service.
argument-hint: "[project-name or blank for cwd]"
allowed-tools: Bash Read Write Edit
---

# Setup Rust Project

## Resolve target

If `$ARGUMENTS` blank: work in current dir, use its name as project name.
If `$ARGUMENTS` given: create and enter `./$ARGUMENTS`.

## Prerequisites

Verify cargo is available. Stop if missing (tell user to install via rustup).

## Initialize

Run `cargo init --name <name>`. Skip if Cargo.toml already exists.

## Dependencies

Use `cargo add` — never hardcode versions in Cargo.toml.
Only add deps that are not already present in Cargo.toml.

Add if missing: `anyhow`, `tokio` (full features), `tracing`, `tracing-subscriber` (env-filter + json features), `serde` (derive feature), `serde_json`, `dotenvy`.
Add dev if missing: `tokio-test`.

## Configure

For each file: create if missing, update if present but incomplete — never overwrite user customizations.

- **rust-toolchain.toml** — stable channel, rustfmt + clippy components
- **rustfmt.toml** — 100 max width, Crate imports granularity, StdExternalCrate grouping
- **.clippy.toml** — set msrv to current stable, `deny = ["clippy::all"]`
- **.gitignore** — append `/target`, `.env*` if not already excluded
- **.env.example** — add `RUST_LOG=info` if missing

## Starter files

Replace `src/main.rs` only if it's the default cargo stub. Use tokio async main with tracing init.
Create `README.md` only if missing.

## Git hooks

Set up git hooks: pre-commit runs `cargo fmt --check` + `cargo clippy -- -D warnings`, pre-push runs `cargo test`.
Skip if hooks already configured.

## Verify

Run `cargo check`. Report errors but do not fail.

## Done

Output project name, dir, and key commands: `cargo run`, `cargo clippy`, `cargo test`.
