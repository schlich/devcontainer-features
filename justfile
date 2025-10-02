test *args:
    devcontainer features test -p . {{ args }}

# Bump version for a specific feature
bump-version feature type="patch" dry_run="":
    python3 scripts/bump-version.py --feature {{ feature }} --type {{ type }} {{ dry_run }}

# Bump version for all features
bump-all-versions type="patch" dry_run="":
    python3 scripts/bump-version.py --all --type {{ type }} {{ dry_run }}