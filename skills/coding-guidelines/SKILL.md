---
name: coding-guidelines
description: project coding guidelines input validation, error handling, DDD structure, type safety, testing, gRPC, Rust, linting, and more. Invoke when writing, reviewing, or planning code — including setting up a backend, API, service, or any new project.
version: 0.1.2
---

# Coding Guidelines

Apply these rules when writing or reviewing code.

## Client Error Messages

Client must not hardcode error message strings. Display message received from server response directly to user.

## Colocation

Keep info next to its source: spec files beside logic files, JSDoc instead of separate doc files, tests colocated with implementation.

## DDD Folder Structure

Organize code by domain, not by layer. Each domain owns its models, services, repositories, and interfaces in a single cohesive directory.

## Use gRPC

Prefer gRPC over REST for internal service communication. Use REST only when clients cannot support gRPC (e.g., browsers without grpc-web).

## Handle All Cases

Handle every branch, edge case, and error path — never skip logic with a stub, empty catch, or silent fallthrough.

## Use Type-Safe i18n Library

Use an i18n library that supports type-safe language JSON files. This ensures translation keys are validated at compile time and refactoring is safe.

## Prefer Existing Libraries

Prefer using an existing library over implementing logic yourself. Before writing custom code, check if a well-maintained library already solves the problem.

## Prefer Static Site Generation

Prefer SSG over SSR or client-side rendering whenever content does not require per-request dynamic data.

## Rust Error Handling

Use `Result`/`Option` and pattern matching instead of panicking or throwing. Never use `unwrap`/`expect` in production paths; propagate errors with `?` or match exhaustively.

## Use SDKs for Network Communications

Always use official SDKs for network communications. Never use plain HTTP/fetch/axios calls directly.

## Small Atomic Changes

Always make small changes. Each change should be self-contained and easy to track in version control.

## Strangler Fig Principle

Migrate legacy systems incrementally by routing new functionality to new code alongside the old, not in a big-bang rewrite.
Remove the old code only once the new path fully covers its behavior.

## Strict Git Hooks

Run full lint, type-check, and test suite in pre-commit; run build and integration tests in pre-push. Never allow `--no-verify` to bypass hooks.

## Strict Linting

Enable all available linter rules and set warnings as errors. Never disable or suppress lint rules inline or in config without team approval.

## Test Coverage

Aim for 100% test coverage. Every code path, branch, and edge case must have a corresponding test.

## Use Type-Safe Languages

Never use Python. Always choose type-safe languages; prefer Rust for new projects.

## Validate Environment Values

Always validate env values at startup using a schema library (e.g. `env-schema`, `zod`, `envalid`). Never access raw `process.env` without validation.

## Validate Inputs and Network Input

Always validate data at system boundaries: user inputs, API responses, and any network-received data before use.

