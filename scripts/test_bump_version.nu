#!/usr/bin/env nu
# Test script for bump-version.nu

def main [] {
    print "=== Testing bump-version.nu ==="
    print ""
    
    # Test 1: Check script exists
    print "1. Checking if bump-version.nu exists..."
    let script_path = "scripts/bump-version.nu"
    if not ($script_path | path exists) {
        print $"  ❌ Error: ($script_path) not found"
        exit 1
    }
    print "  ✓ Script exists"
    print ""
    
    # Test 2: Test dry-run on single feature
    print "2. Testing dry-run on single feature (just)..."
    let result = (nu scripts/bump-version.nu --feature just --type patch --dry-run 
        | complete)
    
    if $result.exit_code != 0 {
        print $"  ❌ Error: Script failed with exit code ($result.exit_code)"
        print $result.stderr
        exit 1
    }
    
    if ($result.stdout | str contains "0.1.0 → 0.1.1") {
        print "  ✓ Dry-run works correctly"
    } else {
        print "  ❌ Error: Unexpected output"
        print $result.stdout
        exit 1
    }
    print ""
    
    # Test 3: Test dry-run with all features
    print "3. Testing dry-run with all features..."
    let result = (nu scripts/bump-version.nu --all --type patch --dry-run 
        | complete)
    
    if $result.exit_code != 0 {
        print $"  ❌ Error: Script failed with exit code ($result.exit_code)"
        print $result.stderr
        exit 1
    }
    
    if ($result.stdout | str contains "Bumping patch version") {
        print "  ✓ All features dry-run works"
    } else {
        print "  ❌ Error: Unexpected output"
        exit 1
    }
    print ""
    
    # Test 4: Test different bump types
    print "4. Testing different bump types..."
    
    for bump_type in ["major", "minor", "patch"] {
        let result = (nu scripts/bump-version.nu --feature cypress --type $bump_type --dry-run 
            | complete)
        
        if $result.exit_code != 0 {
            print $"  ❌ Error: ($bump_type) bump failed"
            exit 1
        }
    }
    print "  ✓ All bump types work (major, minor, patch)"
    print ""
    
    print "==================================="
    print "✅ ALL TESTS PASSED!"
    print "==================================="
}
