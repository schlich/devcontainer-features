#!/usr/bin/env nu
# Bump version script for devcontainer features
# This script bumps the version of a devcontainer feature in its devcontainer-feature.json file.
# It follows semantic versioning (MAJOR.MINOR.PATCH).

def main [
    --feature (-f): string      # Feature name (directory name in src/)
    --all (-a)                  # Bump version for all features
    --type (-t): string         # Type of version bump (major, minor, patch)
    --dry-run (-n)              # Show what would be changed without making changes
] {
    # Validate that either --feature or --all is provided
    if ($feature == null and not $all) {
        error make {msg: "Error: Either --feature or --all must be specified"}
    }
    
    if ($feature != null and $all) {
        error make {msg: "Error: Cannot specify both --feature and --all"}
    }
    
    # Validate bump type
    if ($type not-in ["major", "minor", "patch"]) {
        error make {msg: "Error: --type must be one of: major, minor, patch"}
    }
    
    # Find the src directory
    let repo_root = ($env.FILE_PWD | path dirname)
    let src_dir = ($repo_root | path join "src")
    
    if not ($src_dir | path exists) {
        error make {msg: $"Error: src directory not found at ($src_dir)"}
    }
    
    # Process features
    if $all {
        # Get all feature directories
        let features = (ls $src_dir 
            | where type == dir 
            | get name 
            | each { |dir| 
                let json_file = ($dir | path join "devcontainer-feature.json")
                if ($json_file | path exists) {
                    $dir
                } else {
                    null
                }
            }
            | where $it != null
        )
        
        if ($features | is-empty) {
            error make {msg: "Error: No features found in src/"}
        }
        
        print $"Bumping ($type) version for ($features | length) features...\n"
        
        $features | each { |feature_dir|
            bump_feature_version $feature_dir $type $dry_run
            print ""
        }
    } else {
        # Single feature
        let feature_dir = ($src_dir | path join $feature)
        
        if not ($feature_dir | path exists) {
            error make {msg: $"Error: Feature directory not found: ($feature_dir)"}
        }
        
        bump_feature_version $feature_dir $type $dry_run
    }
}

# Bump version for a single feature
def bump_feature_version [
    feature_path: string
    bump_type: string
    dry_run: bool
] {
    let json_path = ($feature_path | path join "devcontainer-feature.json")
    
    if not ($json_path | path exists) {
        error make {msg: $"Error: File not found: ($json_path)"}
    }
    
    # Read and parse JSON
    let data = try {
        open $json_path
    } catch {
        error make {msg: $"Error: Invalid JSON in ($json_path)"}
    }
    
    # Check if version field exists
    if not ("version" in ($data | columns)) {
        error make {msg: $"Error: No 'version' field found in ($json_path)"}
    }
    
    let old_version = $data.version
    let new_version = (bump_semver $old_version $bump_type)
    
    # Print info
    print $"Feature: ($data.id? | default 'unknown')"
    print $"  ($old_version) → ($new_version)"
    
    if $dry_run {
        print "  (dry run - no changes made)"
        return
    }
    
    # Update version and write back
    let updated_data = ($data | upsert version $new_version)
    $updated_data | to json --indent 4 | save --force $json_path
    
    # Add newline at end of file (to match Python behavior)
    "\n" | save --append $json_path
    
    print $"  ✓ Updated ($json_path)"
}

# Bump a semantic version string
# Uses the nu_plugin_inc if available, otherwise falls back to custom implementation
def bump_semver [
    version: string
    bump_type: string
]: nothing -> string {
    # Try to use inc plugin if available
    let inc_result = try {
        match $bump_type {
            "major" => { $version | inc --major }
            "minor" => { $version | inc --minor }
            "patch" => { $version | inc --patch }
            _ => { error make {msg: $"Error: Invalid bump type: ($bump_type)"} }
        }
    } catch {
        null
    }
    
    # If inc plugin worked, return the result
    if $inc_result != null {
        return $inc_result
    }
    
    # Fallback to custom implementation if inc plugin is not available
    let parts = ($version | split row ".")
    
    if ($parts | length) != 3 {
        error make {msg: $"Error: Version must have exactly 3 parts: ($version)"}
    }
    
    let major = ($parts | get 0 | into int)
    let minor = ($parts | get 1 | into int)
    let patch = ($parts | get 2 | into int)
    
    match $bump_type {
        "major" => {
            $"($major + 1).0.0"
        }
        "minor" => {
            $"($major).($minor + 1).0"
        }
        "patch" => {
            $"($major).($minor).($patch + 1)"
        }
        _ => {
            error make {msg: $"Error: Invalid bump type: ($bump_type)"}
        }
    }
}
