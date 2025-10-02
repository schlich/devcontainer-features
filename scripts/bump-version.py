#!/usr/bin/env python3
"""
Bump version script for devcontainer features.

This script bumps the version of a devcontainer feature in its devcontainer-feature.json file.
It follows semantic versioning (MAJOR.MINOR.PATCH).
"""

import argparse
import json
import sys
from pathlib import Path


def parse_version(version_str):
    """Parse a semantic version string into major, minor, patch integers."""
    try:
        parts = version_str.split('.')
        if len(parts) != 3:
            raise ValueError(f"Version must have exactly 3 parts: {version_str}")
        return tuple(int(p) for p in parts)
    except (ValueError, AttributeError) as e:
        print(f"Error: Invalid version format: {version_str}", file=sys.stderr)
        print(f"Version must be in format MAJOR.MINOR.PATCH (e.g., 1.2.3)", file=sys.stderr)
        sys.exit(1)


def bump_version(version_str, bump_type):
    """Bump a version string according to the bump type."""
    major, minor, patch = parse_version(version_str)
    
    if bump_type == 'major':
        major += 1
        minor = 0
        patch = 0
    elif bump_type == 'minor':
        minor += 1
        patch = 0
    elif bump_type == 'patch':
        patch += 1
    else:
        raise ValueError(f"Invalid bump type: {bump_type}")
    
    return f"{major}.{minor}.{patch}"


def update_feature_version(feature_path, bump_type, dry_run=False):
    """Update the version in a devcontainer-feature.json file."""
    json_path = Path(feature_path) / "devcontainer-feature.json"
    
    if not json_path.exists():
        print(f"Error: File not found: {json_path}", file=sys.stderr)
        sys.exit(1)
    
    try:
        with open(json_path, 'r') as f:
            data = json.load(f)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON in {json_path}: {e}", file=sys.stderr)
        sys.exit(1)
    
    if 'version' not in data:
        print(f"Error: No 'version' field found in {json_path}", file=sys.stderr)
        sys.exit(1)
    
    old_version = data['version']
    new_version = bump_version(old_version, bump_type)
    
    print(f"Feature: {data.get('id', 'unknown')}")
    print(f"  {old_version} → {new_version}")
    
    if dry_run:
        print("  (dry run - no changes made)")
        return old_version, new_version
    
    data['version'] = new_version
    
    with open(json_path, 'w') as f:
        json.dump(data, f, indent=4)
        f.write('\n')
    
    print(f"  ✓ Updated {json_path}")
    
    return old_version, new_version


def main():
    parser = argparse.ArgumentParser(
        description='Bump version for devcontainer features',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Bump patch version for a single feature
  python3 scripts/bump-version.py --feature just --type patch
  
  # Bump minor version for a feature (dry run)
  python3 scripts/bump-version.py --feature playwright --type minor --dry-run
  
  # Bump major version for all features
  python3 scripts/bump-version.py --all --type major
        """
    )
    
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--feature', '-f', help='Feature name (directory name in src/)')
    group.add_argument('--all', '-a', action='store_true', help='Bump version for all features')
    
    parser.add_argument(
        '--type', '-t',
        required=True,
        choices=['major', 'minor', 'patch'],
        help='Type of version bump'
    )
    
    parser.add_argument(
        '--dry-run', '-n',
        action='store_true',
        help='Show what would be changed without making changes'
    )
    
    args = parser.parse_args()
    
    # Find the src directory
    script_dir = Path(__file__).parent
    repo_root = script_dir.parent
    src_dir = repo_root / "src"
    
    if not src_dir.exists():
        print(f"Error: src directory not found at {src_dir}", file=sys.stderr)
        sys.exit(1)
    
    if args.all:
        # Get all feature directories
        features = [d for d in src_dir.iterdir() if d.is_dir() and (d / "devcontainer-feature.json").exists()]
        if not features:
            print("Error: No features found in src/", file=sys.stderr)
            sys.exit(1)
        
        print(f"Bumping {args.type} version for {len(features)} features...\n")
        
        for feature_dir in sorted(features):
            update_feature_version(feature_dir, args.type, args.dry_run)
            print()
    else:
        # Single feature
        feature_dir = src_dir / args.feature
        if not feature_dir.exists():
            print(f"Error: Feature directory not found: {feature_dir}", file=sys.stderr)
            sys.exit(1)
        
        update_feature_version(feature_dir, args.type, args.dry_run)


if __name__ == '__main__':
    main()
