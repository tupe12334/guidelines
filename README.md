# Guidelines

Coding guidelines as a Claude Code plugin.

## Consume

Add to your project's `.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "guidelines@https://github.com/tupe12334/guidelines": true
  }
}
```

Marketplace index: `https://github.com/tupe12334/guidelines/blob/main/.claude-plugin/marketplace.json`

Claude Code will install the plugin and make the `coding-guidelines` skill available.

## Build

After adding or editing rules, regenerate the skill:

```bash
bash scripts/build-skill.sh
```
