# Version Bumping Infrastructure

This document describes the infrastructure for bumping versions of devcontainer features in this repository.

## Overview

All devcontainer features in this repository follow [Semantic Versioning](https://semver.org/) (MAJOR.MINOR.PATCH):
- **MAJOR**: Incompatible API changes
- **MINOR**: New functionality in a backward-compatible manner
- **PATCH**: Backward-compatible bug fixes

## Tools

### Bump Version Script

The `scripts/bump-version.py` script automates version bumping for features.

#### Usage

```bash
# Bump patch version for a single feature
python3 scripts/bump-version.py --feature just --type patch

# Bump minor version for a feature (dry run to preview)
python3 scripts/bump-version.py --feature playwright --type minor --dry-run

# Bump major version for all features
python3 scripts/bump-version.py --all --type major

# Bump patch version for all features (dry run)
python3 scripts/bump-version.py --all --type patch --dry-run
```

#### Options

- `--feature FEATURE` or `-f FEATURE`: Specify a single feature to bump
- `--all` or `-a`: Bump all features
- `--type {major,minor,patch}` or `-t {major,minor,patch}`: Type of version bump (required)
- `--dry-run` or `-n`: Preview changes without modifying files

### Just Recipes

If you have [just](https://github.com/casey/just) installed, you can use convenient recipes:

```bash
# Bump a single feature
just bump-version just patch
just bump-version playwright minor --dry-run

# Bump all features
just bump-all-versions patch
just bump-all-versions minor --dry-run
```

## Workflow

### When to Bump Versions

- **Patch**: Bug fixes, documentation updates, minor improvements
- **Minor**: New features, new options, backward-compatible changes
- **Major**: Breaking changes, removed options, significant behavior changes

### Process

1. **Make your changes** to the feature (install scripts, documentation, etc.)

2. **Bump the version** using one of the tools above:
   ```bash
   python3 scripts/bump-version.py --feature YOUR_FEATURE --type patch
   ```

3. **Review the change**:
   ```bash
   git diff src/YOUR_FEATURE/devcontainer-feature.json
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "Bump YOUR_FEATURE version to X.Y.Z"
   ```

5. **Create a pull request**

### Automated Validation

When you create a pull request that modifies `devcontainer-feature.json` files, the "Validate Version Bump" workflow automatically:

- ✅ Checks that versions follow semantic versioning format
- ✅ Ensures versions don't decrease
- ✅ Reports version changes clearly
- ⚠️ Warns if versions are unchanged (but doesn't fail the build)

### Publishing

After your PR is merged to main, the "CI - Test Features" workflow:

1. Validates all features
2. Runs tests
3. Publishes features to GitHub Container Registry (GHCR)
4. Generates updated documentation
5. Creates a PR with documentation updates

## Examples

### Example 1: Fix a Bug in a Feature

```bash
# 1. Make your fix
vim src/just/install.sh

# 2. Bump patch version
python3 scripts/bump-version.py --feature just --type patch

# 3. Commit and push
git add .
git commit -m "Fix just installation on ARM architecture

Bump version to 0.1.1"
git push origin my-bugfix-branch
```

### Example 2: Add a New Option

```bash
# 1. Add the new option
vim src/playwright/devcontainer-feature.json
vim src/playwright/install.sh

# 2. Bump minor version
python3 scripts/bump-version.py --feature playwright --type minor

# 3. Commit and push
git add .
git commit -m "Add headless option to playwright feature

Bump version to 0.2.0"
git push origin my-feature-branch
```

### Example 3: Bulk Patch Update

```bash
# 1. Make changes to multiple features
vim src/*/install.sh

# 2. Bump all features (preview first)
python3 scripts/bump-version.py --all --type patch --dry-run

# 3. Apply the changes
python3 scripts/bump-version.py --all --type patch

# 4. Review and commit
git diff
git add .
git commit -m "Update all features to use updated base image

Bump all feature versions"
git push origin bulk-update-branch
```

## Integration with devcontainer CLI

This infrastructure works seamlessly with the devcontainer CLI:

```bash
# Validate features
devcontainer features test -p .

# Test a specific feature
devcontainer features test -f just -i debian:bookworm

# Publish features (done automatically in CI)
devcontainer features publish ./src --namespace YOUR_NAMESPACE
```

## Troubleshooting

### Script shows "File not found" error

Make sure you're running the script from the repository root:
```bash
cd /path/to/devcontainer-features
python3 scripts/bump-version.py --feature just --type patch
```

### Version validation fails in CI

The validation workflow checks that:
- Versions follow the X.Y.Z format
- Versions don't decrease
- JSON files are valid

Review the error message in the workflow logs and fix the issue.

### Just command not found

Install just using the package manager or from [releases](https://github.com/casey/just/releases):
```bash
# Using cargo
cargo install just

# Or download binary
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/bin
```

## See Also

- [Semantic Versioning](https://semver.org/)
- [devcontainer CLI Documentation](https://containers.dev/guide/cli)
- [devcontainers/action](https://github.com/devcontainers/action)
