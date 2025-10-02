#!/usr/bin/env python3
"""
Tests for the bump-version script.
"""

import json
import tempfile
import shutil
from pathlib import Path
import sys
import os

# Add scripts directory to path
script_dir = Path(__file__).parent
sys.path.insert(0, str(script_dir))

# Import from the bump-version script
import importlib.util
spec = importlib.util.spec_from_file_location("bump_version", script_dir / "bump-version.py")
bump_version_module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bump_version_module)

bump_version = bump_version_module.bump_version
parse_version = bump_version_module.parse_version
update_feature_version = bump_version_module.update_feature_version


def test_parse_version():
    """Test version parsing."""
    assert parse_version("1.2.3") == (1, 2, 3)
    assert parse_version("0.0.1") == (0, 0, 1)
    assert parse_version("10.20.30") == (10, 20, 30)
    print("✓ test_parse_version passed")


def test_bump_version():
    """Test version bumping logic."""
    # Patch
    assert bump_version("1.2.3", "patch") == "1.2.4"
    assert bump_version("0.0.0", "patch") == "0.0.1"
    
    # Minor
    assert bump_version("1.2.3", "minor") == "1.3.0"
    assert bump_version("0.0.5", "minor") == "0.1.0"
    
    # Major
    assert bump_version("1.2.3", "major") == "2.0.0"
    assert bump_version("0.5.9", "major") == "1.0.0"
    
    print("✓ test_bump_version passed")


def test_update_feature_version():
    """Test updating a feature version in a JSON file."""
    
    # Create a temporary directory with a test feature
    with tempfile.TemporaryDirectory() as tmpdir:
        feature_dir = Path(tmpdir) / "test-feature"
        feature_dir.mkdir()
        
        json_path = feature_dir / "devcontainer-feature.json"
        test_data = {
            "id": "test-feature",
            "version": "1.0.0",
            "name": "Test Feature"
        }
        
        with open(json_path, 'w') as f:
            json.dump(test_data, f)
        
        # Test patch bump
        old_ver, new_ver = update_feature_version(feature_dir, "patch")
        assert old_ver == "1.0.0"
        assert new_ver == "1.0.1"
        
        # Verify the file was updated
        with open(json_path, 'r') as f:
            updated_data = json.load(f)
        assert updated_data["version"] == "1.0.1"
        
        print("✓ test_update_feature_version passed")


if __name__ == '__main__':
    print("Running bump-version tests...")
    test_parse_version()
    test_bump_version()
    test_update_feature_version()
    print("\n✅ All tests passed!")
