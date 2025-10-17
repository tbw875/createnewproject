# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a multi-language project template generator created using the `createnewproject` script. The script supports multiple project types including Python, Node.js, Bun, Rust, Go, Next.js, Vite, and Svelte projects.

## Development Setup

This repository contains the `main.sh` script for creating new projects. The script itself doesn't require special setup - it's a bash script that creates projects in various languages.

## Common Commands

### Script Usage
- **Create new project**: `./main.sh <project_name> [--template <template>] [--public] [--no-venv]`
- **Available templates**: basic, flask, jupyter, fastapi, cli, nodejs, bun, rust, go, nextjs, vite, svelte, react, vue, express
- **Examples**:
  - `./main.sh my-python-app --template basic`
  - `./main.sh my-web-app --template nodejs --public`
  - `./main.sh my-rust-app --template rust --no-venv`

### Development
- **Edit script**: Modify `main.sh` to add new templates or features
- **Test changes**: Create test projects in `/tmp` directory

## Project Structure

- `main.sh` - Main project creation script
- `CLAUDE.md` - This documentation file
- `README.md` - Project documentation

## Architecture Notes

This is a multi-language project template generator that:
- Supports 15+ different project types/languages
- Integrates with native package managers and build tools for each language
- Creates appropriate .gitignore files with patterns for all supported languages
- Automatically creates GitHub repositories and pushes initial commits
- Generates template-specific README files with relevant commands

### Supported Templates

- **Python**: basic, flask, jupyter, fastapi, cli (creates venv, requirements.txt, pytest tests)
- **JavaScript/TypeScript**: nodejs (npm init), bun (bun init), nextjs, vite, svelte, react (create-react-app), vue (npm create vue), express (TypeScript server)
- **Systems**: rust (cargo init), go (go mod init)

The script wraps native project initialization tools while adding consistent Git setup, GitHub integration, and project structure.