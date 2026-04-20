# Validate Environment Values

Always validate env values at startup using a schema library (e.g. `env-schema`, `zod`, `envalid`). Never access raw `process.env` without validation.
