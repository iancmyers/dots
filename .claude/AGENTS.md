# Agent Instructions

This repository contains dotfiles and configuration files for setting up a development environment.

## Project Structure

- Dotfiles (`.aliases`, `.zshrc`, `.exports`, etc.) are symlinked to the home directory
- VS Code settings (`.code/`) are merged and copied to the VS Code user directory
- Claude config (`.claude/home/`) is symlinked to `~/.claude/`

## Setup

### Prerequisites

- macOS with zsh as the default shell
- `jq` installed (`brew install jq`) for VS Code settings merging
- Git installed

### Installation

1. Clone the repository:

   ```bash
   git clone <repo-url> ~/projects/dots
   cd ~/projects/dots
   ```

2. Run the setup script:

   ```bash
   ./symlink.sh
   ```

   This will:

   - Create an empty `.private` file for machine-specific secrets
   - Symlink all dotfiles to the home directory
   - Merge VS Code settings (shared + local) into the VS Code user directory
   - Symlink VS Code snippets
   - Symlink Claude config to `~/.claude/`

3. (Optional) Create machine-specific VS Code settings:

   ```bash
   cp .code/settings.local.example.json .code/settings.local.json
   # Edit .code/settings.local.json with your machine-specific settings
   ./symlink.sh  # Re-run to merge the new settings
   ```

4. Open a new terminal tab to load the new shell configuration.

## VS Code Settings

VS Code settings are split into shared and machine-specific files:

- **`.code/settings.json`** - Shared settings that work across all machines (committed)
- **`.code/settings.local.json`** - Machine-specific settings (gitignored)
- **`.code/settings.local.example.json`** - Template showing what local settings might be needed

The symlink script uses `jq` to merge these files, with local settings taking precedence. Settings that should go in the local file include:

- Paths containing usernames or machine-specific locations
- `claudeCode.environmentVariables`
- `claudeCode.claudeProcessWrapper`
- `claudeCode.selectedModel`
- `json.schemas` with local file paths

## Shell Startup Performance

Shell initialization uses lazy loading for version managers to minimize startup time:

- **nvm** - Loaded on first use of `nvm`, `node`, `npm`, or `npx`
- **rbenv** - Loaded on first use of `ruby`, `gem`, `bundle`, or `rbenv`

This defers the slow initialization until actually needed.

## Guidelines

- Keep configurations minimal and well-documented
- Test changes before committing
- Avoid storing sensitive information in version control (use `.private` for secrets)
- Machine-specific VS Code settings go in `.code/settings.local.json`
