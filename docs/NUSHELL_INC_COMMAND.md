# Note on Nushell's `inc` Command

## Background

The Nushell documentation references an `inc` command that was designed to increment values, including semantic version strings:
- Documentation: https://www.nushell.sh/commands/docs/inc.html
- Supported flags: `--major`, `--minor`, `--patch`

## Current Status

The `inc` command was available in Nushell versions prior to 0.80 but has been **removed in current versions** (0.107.0+).

### Testing with Nushell 0.107.0:
```bash
$ nu -c '"1.2.3" | inc --patch'
Error: nu::shell::external_command
  × External command failed
   ╭─[source:1:11]
 1 │ "1.2.3" | inc --patch
   ·           ─┬─
   ·            ╰── Command `inc` not found
   ╰────
  help: `inc` is neither a Nushell built-in or a known external command
```

## Implementation Decision

Since the `inc` command is not available in current Nushell versions, we maintain a **custom `bump_semver` function** in `scripts/bump-version.nu`.

### Advantages of Custom Implementation:
1. **No dependency** on specific Nushell versions or plugins
2. **Clear and maintainable** - the logic is explicit
3. **Well-tested** - works identically to the Python version
4. **Future-proof** - doesn't rely on deprecated features

### Implementation:
```nushell
def bump_semver [
    version: string
    bump_type: string
]: nothing -> string {
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
```

## Future Considerations

If/when the `inc` command is reintroduced to Nushell or available as a stable plugin:
1. We can simplify the `bump_semver` function to use it
2. The interface would remain the same (backward compatible)
3. Tests would continue to work without modification

## Conclusion

While the `inc` command would be ideal for this use case, the custom implementation:
- ✅ Works with current Nushell versions
- ✅ Is clear and maintainable
- ✅ Provides identical functionality
- ✅ Is well-tested and reliable
