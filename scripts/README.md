# Scripts

This directory contains scripts for maintaining devcontainer features.

## bump-version.py

Python script to bump version numbers in `devcontainer-feature.json` files.

See [../docs/VERSION_BUMPING.md](../docs/VERSION_BUMPING.md) for complete documentation.

### Quick Usage

```bash
# Bump a single feature
python3 scripts/bump-version.py --feature just --type patch

# Bump all features
python3 scripts/bump-version.py --all --type minor

# Dry run (preview changes)
python3 scripts/bump-version.py --feature playwright --type patch --dry-run
```

## test_bump_version.py

Unit tests for the bump-version script.

### Running Tests

```bash
python3 scripts/test_bump_version.py
```

All tests should pass before committing changes to the bump-version script.
