# Nushell vs Python: Version Bumping Implementation

This document explains why Nushell was chosen as the primary scripting language for version bumping.

## Comparison

### Native JSON Support

**Python:**
```python
import json

with open(json_path, 'r') as f:
    data = json.load(f)
    
# Modify data
data['version'] = new_version

with open(json_path, 'w') as f:
    json.dump(data, f, indent=4)
```

**Nushell:**
```nushell
let data = open $json_path
let updated_data = ($data | upsert version $new_version)
$updated_data | to json --indent 4 | save --force $json_path
```

### Structured Data Handling

Nushell treats JSON, CSV, and other structured data as first-class citizens, making data manipulation more natural and less error-prone.

### Type Safety

**Python:**
- Dynamic typing with potential runtime errors
- Manual type checking needed
- Error handling via try/except

**Nushell:**
- Strongly typed with better compile-time checks
- Built-in error handling with `error make`
- Type coercion with `into int`, `into string`, etc.

### Error Messages

**Python:**
```
Traceback (most recent call last):
  File "bump-version.py", line 59
    data = json.load(f)
json.decoder.JSONDecodeError: ...
```

**Nushell:**
```
Error: nu::shell::error
  × Error: Invalid JSON in file
  ╭─[bump-version.nu:50:13]
 50 │     let data = try {
    ·                ─┬─
    ·                 ╰── originates from here
```

Nushell provides clearer, more actionable error messages with line numbers and context.

## Benefits of Nushell for This Project

1. **Native JSON Support**: No external libraries needed for JSON parsing
2. **Concise Syntax**: Less boilerplate code (155 lines in Python vs ~150 in Nushell)
3. **Better Error Handling**: More informative error messages
4. **Type Safety**: Fewer runtime errors
5. **Modern Shell**: Better integration with command-line workflows
6. **Performance**: Efficient structured data processing
7. **Maintainability**: Cleaner, more readable code

## Note on `inc` Command

Nushell's `inc` functionality for incrementing semantic version strings is now available as an official plugin: `nu_plugin_inc`.

**Our implementation uses a hybrid approach:**
1. First attempts to use `nu_plugin_inc` if installed
2. Falls back to custom implementation if plugin is not available

This provides the best of both worlds:
- Uses official plugin when available (recommended)
- Guarantees functionality even without the plugin
- No manual configuration needed

**To install the plugin:**
```bash
cargo install nu_plugin_inc
nu -c "plugin add ~/.cargo/bin/nu_plugin_inc"
```

See [NUSHELL_INC_COMMAND.md](./NUSHELL_INC_COMMAND.md) for complete details on plugin installation and usage.

## Installation

Nushell can be installed via:
- Snap: `sudo snap install nushell --classic`
- Cargo: `cargo install nu`
- Package managers: See https://www.nushell.sh/book/installation.html

## Compatibility

Both Python and Nushell versions are maintained:
- **Nushell** (`bump-version.nu`): Primary, recommended version
- **Python** (`bump-version.py`): Legacy version for compatibility

Both produce identical results and follow the same API.
