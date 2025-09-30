# Changelog

All notable changes to the Academic Website Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.1] - 2025-09-30

### Added
- **Frontmatter Wikilinks Support**: Wikilinks now work in YAML frontmatter fields (slides, pdf, video, etc.)
- **Ruby 3.4+ Compatibility**: Added `bigdecimal` gem for newer Ruby versions

### Fixed
- Wikilink conversion in frontmatter fields like `slides: [[../assets/file.pdf]]`
- Build errors on Ruby 3.4+ due to missing standard library gems

## [2.0.0] - 2024-09-07

### Added
- **Obsidian Wikilinks Support**: Custom Jekyll plugin for `[[wikilink]]` syntax
- **Content Assets in Vault**: All user files (PDFs, images, slides) now in `vault/assets/`
- **Dark Theme Toggle**: Persistent dark/light mode with localStorage
- **Enhanced LaTeX Rendering**: Fixed display equations with `$$` delimiters
- **Version Tracking**: VERSION file and automatic update checking
- **Smart Update System**: PR-based updates with auto-merge when safe
- **Migration Support**: Automatic path migration for existing users
- **Example Content**: LaTeX examples and Obsidian wikilinks demo pages

### Changed
- **Asset Organization**: Separated design assets (`assets/`) from user content (`vault/assets/`)
- **Update Script**: Enhanced `update-design.sh` with backward compatibility and migration
- **Jekyll Filters**: Replaced deprecated `limit` with `slice` throughout
- **MathJax Configuration**: Improved for better equation rendering

### Fixed
- Display equation rendering with `$$` delimiters
- Asset path references throughout content
- Cross-platform compatibility in update script

### Documentation
- Comprehensive README updates
- CLAUDE.md for AI-assisted development
- File management guide for Obsidian users
- Update system documentation

## [1.0.0] - 2024-07-20

### Added
- Initial template release
- Jekyll-based static site generator
- Obsidian vault integration
- Computer Modern typography
- Basic MathJax support
- GitHub Actions deployment
- Collection types for academic content

---

## Version Number Guide

- **Major (X.0.0)**: Breaking changes requiring user action
- **Minor (0.X.0)**: New features, backward compatible
- **Patch (0.0.X)**: Bug fixes, minor improvements