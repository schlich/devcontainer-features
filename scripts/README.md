# Scripts

This directory contains scripts for maintaining devcontainer features.

## bump-version.nu (Recommended)

Nushell script to bump version numbers in `devcontainer-feature.json` files. This is the primary version bumping tool.

### Why Nushell?

- Native JSON support without external dependencies
- Modern, type-safe shell with better error handling
- Clean, readable syntax
- Efficient structured data processing
- Optional plugin support for enhanced functionality

### Plugin Support

The script automatically uses the `nu_plugin_inc` plugin if installed, providing official Nushell support for semantic versioning:

```bash
# Install the plugin (optional but recommended)
cargo install nu_plugin_inc
nu -c "plugin add ~/.cargo/bin/nu_plugin_inc"
```

The script works with or without the plugin - it automatically detects and uses it if available.

See [../docs/VERSION_BUMPING.md](../docs/VERSION_BUMPING.md) for complete documentation.

### Quick Usage

```bash
# Bump a single feature
nu scripts/bump-version.nu --feature just --type patch

# Bump all features
nu scripts/bump-version.nu --all --type minor

# Dry run (preview changes)
nu scripts/bump-version.nu --feature playwright --type patch --dry-run
```

## bump-version.py (Legacy)

Python script for version bumping, maintained for compatibility. The Nushell version is recommended for new usage.

```bash
# Same usage as Nushell version
python3 scripts/bump-version.py --feature just --type patch
```

## test_bump_version.py

Unit tests for the Python bump-version script.

### Running Tests

```bash
python3 scripts/test_bump_version.py
```

All tests should pass before committing changes to the bump-version script.
