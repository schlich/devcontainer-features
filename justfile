test *args:
    devcontainer features test -p . {{ args }}

# Bump version for a specific feature (nushell version)
bump-version feature type="patch" dry_run="":
    nu scripts/bump-version.nu --feature {{ feature }} --type {{ type }} {{ dry_run }}

# Bump version for all features (nushell version)
bump-all-versions type="patch" dry_run="":
    nu scripts/bump-version.nu --all --type {{ type }} {{ dry_run }}

# Bump version for a specific feature (python version - legacy)
bump-version-py feature type="patch" dry_run="":
    python3 scripts/bump-version.py --feature {{ feature }} --type {{ type }} {{ dry_run }}

# Bump version for all features (python version - legacy)
bump-all-versions-py type="patch" dry_run="":
    python3 scripts/bump-version.py --all --type {{ type }} {{ dry_run }}