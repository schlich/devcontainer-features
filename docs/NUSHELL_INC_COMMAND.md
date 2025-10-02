# Note on Nushell's `inc` Command

## Background

The Nushell documentation references an `inc` command that was designed to increment values, including semantic version strings:
- Documentation: https://www.nushell.sh/commands/docs/inc.html
- Supported flags: `--major`, `--minor`, `--patch`

## Current Status

The `inc` command was available in Nushell versions prior to 0.80 but has been **moved to a plugin** in current versions (0.107.0+).

### nu_plugin_inc

The `inc` functionality is now available as an official Nushell plugin: `nu_plugin_inc`

## Installation

### Step 1: Install the Plugin

```bash
cargo install nu_plugin_inc
```

### Step 2: Register the Plugin with Nushell

```bash
# Start nushell
nu

# Register the plugin
plugin add ~/.cargo/bin/nu_plugin_inc

# Or in one command:
nu -c "plugin add ~/.cargo/bin/nu_plugin_inc"
```

### Step 3: Verify Installation

```bash
nu -c '"1.2.3" | inc --patch'
# Should output: 1.2.4
```

## Implementation in bump-version.nu

The `scripts/bump-version.nu` script now uses a **hybrid approach**:

1. **First, try to use the `inc` plugin** if it's installed and registered
2. **Fallback to custom implementation** if the plugin is not available

This ensures the script works whether or not the plugin is installed, while preferring the official plugin when available.

### Code Implementation:

```nushell
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
        }
    } catch {
        null
    }
    
    # If inc plugin worked, return the result
    if $inc_result != null {
        return $inc_result
    }
    
    # Fallback to custom implementation
    # [custom implementation code]
}
```

## Benefits

1. **Plugin-first approach**: Uses official nu_plugin_inc when available
2. **Graceful fallback**: Works without the plugin for compatibility
3. **No manual configuration**: Script detects and uses the plugin automatically
4. **Best of both worlds**: Official plugin + guaranteed functionality

## Advantages of Using the Plugin

When the plugin is installed:
- ✅ Uses official, maintained code from the Nushell team
- ✅ Consistent with Nushell ecosystem
- ✅ Automatically updated with plugin updates
- ✅ Better integration with Nushell's type system

## Compatibility

- **With plugin**: Uses `nu_plugin_inc` (recommended)
- **Without plugin**: Uses custom implementation (automatic fallback)
- **Both approaches**: Produce identical results

## Setup in CI/CD

To use the plugin in CI/CD environments, add to your setup:

```yaml
- name: Install nu_plugin_inc
  run: |
    cargo install nu_plugin_inc
    nu -c "plugin add ~/.cargo/bin/nu_plugin_inc"
```

## Conclusion

The script now follows best practices by:
1. Preferring the official `nu_plugin_inc` when available
2. Providing a fallback for environments without the plugin
3. Automatically detecting and using the appropriate method
4. Requiring no changes to the command-line interface
