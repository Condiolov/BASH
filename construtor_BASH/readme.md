# Construtor_BASH

**Construtor_BASH** is a lightweight template engine written in **Bash** for generating dynamic files (HTML, TXT, configs, etc.) using variables and delimited blocks.

## 📋 Features

- Replace variables in templates (e.g., `{VARIABLE}`).
- Process specific blocks within templates using `ON`/`OFF` delimiters.
- Generate complete files or extract individual blocks.
- Simple and lightweight, ideal for scripting automation.

## 📦 Requirements

- Bash

## 🔧 Main Functions

### `set_file NAME FILE`

Registers a template file for processing.

- `NAME`: Internal identifier for the template.
- `FILE`: Path to the template file.

**Example**:

```bash
set_file "PAGE" "template.html"
```

### `set_block BLOCK`

Activates and processes a specific block in the template, replacing variables.

- `BLOCK`: Name of the block (defined between `<!-- ON BLOCK -->` and `<!-- OFF BLOCK -->`).

**Example**:

```bash
set_block "HEADER"
```

### `show_block BLOCK`

Displays the processed content of a block or the entire template.

- If `BLOCK` is the `NAME` from `set_file`, shows the full template.
- If `BLOCK` is a block name, shows only that block.

**Example**:

```bash
show_block "PAGE"
```

### `extract_block BLOCK`

Outputs the processed content of a specific block, useful for saving to a file.

**Example**:

```bash
extract_block "FOOTER" > footer.html
```

## 📖 Template Structure

Templates can include:

- **Variables**: Replaced using `{VARIABLE_NAME}`.
- **Blocks**: Defined with `<!-- ON BLOCK_NAME -->` and `<!-- OFF BLOCK_NAME -->`.

**Example Template** (`template.html`):

```html
<h1>{TITLE}</h1>
<!-- ON HEADER -->
<header>My Header</header>
<!-- OFF HEADER -->
```

## 🚀 Quick Usage

1. Source the script:

   ```bash
   source ./construtor_BASH.sh
   ```

2. Define the template file:

   ```bash
   set_file "PAGE" "template.html"
   ```

3. Set variables:

   ```bash
   TITLE="My Website"
   ```

4. Activate blocks:

   ```bash
   set_block "HEADER"
   ```

5. Output the result:

   ```bash
   show_block "PAGE" > output.html
   ```

## 📝 Notes

- Ensure variable names in templates match those defined in your script.
- Blocks are optional; if none are activated, the entire template is processed with variable substitutions.
- Use `extract_block` to isolate specific sections for reuse.
