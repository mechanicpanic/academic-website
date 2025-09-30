# Academic Website Template - Claude Code Guidelines

## Project Overview

This is an **academic CV and publication website template** built with Jekyll and deeply integrated with Obsidian for content management. It serves as both:
1. A **GitHub Template Repository** - Users can fork and customize it
2. A **Live Example** - Contains sample content to demonstrate all features

**Current Status**: Template with example/placeholder content. All content uses generic "Dr. Academic Name" placeholders.

## Core Architecture

### Technology Stack
- **Static Site Generator**: Jekyll 4.3+
- **Content Management**: Obsidian vault-based workflow
- **Styling**: SCSS with CSS custom properties
- **Typography**: Computer Modern fonts (LaTeX-style)
- **Math Rendering**: MathJax 3
- **Deployment**: GitHub Actions → GitHub Pages
- **Custom Features**: Jekyll plugins for Obsidian wikilinks

### Critical Design Principle: Separation of Concerns

**User Content** (in `vault/`):
- All markdown files (`_pages/`, `_publications/`, `_talks/`, etc.)
- All user files (`vault/assets/` - PDFs, images, slides)
- Obsidian configuration (`.obsidian/`)
- **Never touched by template updates**

**Design/Template** (outside `vault/`):
- Layouts (`_layouts/`)
- Styles (`assets/css/`, `_sass/`)
- Plugins (`_plugins/`)
- Design assets (`assets/images/` - favicon, etc.)
- **Updated via `update-design.sh`**

## Key Features Implemented

### 1. Obsidian Wikilinks Support
- **Plugin**: `_plugins/obsidian_wikilinks.rb`
- Converts `[[Page Name]]` → proper markdown links
- Supports `[[Page Name|Display Text]]` syntax
- Works with all content: pages, publications, talks, etc.
- Functions both locally and in production

### 2. Content Assets in Vault
- `vault/assets/pdfs/` - User's PDF papers
- `vault/assets/images/` - User's photos and images
- `vault/assets/slides/` - Presentation files
- All visible and manageable in Obsidian
- Served by Jekyll at `/vault/assets/...`

### 3. LaTeX/Math Rendering
- MathJax 3 with full configuration
- Inline math: `$...$` or `\(...\)`
- Display math: `$$...$$` or `\[...\]`
- Supports AMS packages, matrices, aligned equations
- Example page at `/latex-examples/`

### 4. Dark Theme
- Toggle button (moon/sun icon) in bottom-right
- Carefully chosen color palette for readability
- Preference saved in localStorage
- Smooth transitions between themes
- No font size controls (removed per user request)

### 5. Jekyll Collections
All configured in `_config.yml` with `collections_dir: vault`:
- `_pages` - Main website pages
- `_publications` - Research papers
- `_talks` - Presentations and seminars
- `_teaching` - Courses taught
- `_experience` - Professional positions
- `_education` - Academic degrees

### 6. Backward-Compatible Updates
- `update-design.sh` v2.0 with migration support
- Detects old structures (assets in wrong place)
- Automatically migrates paths in all files
- Timestamped backups before updates
- Cross-platform (macOS/Linux)

## File Structure

```
pasha-website/
├── _config.yml          # Jekyll configuration - user customizes
├── _layouts/            # HTML templates - updated by script
├── _plugins/            # Custom Jekyll plugins
│   └── obsidian_wikilinks.rb
├── _sass/               # SCSS partials - design only
├── assets/              # DESIGN ASSETS ONLY
│   ├── css/
│   │   └── main.scss   # Main stylesheet
│   └── images/         # Favicon, etc. (NOT user content)
├── vault/               # USER CONTENT - Obsidian vault
│   ├── assets/         # USER FILES (PDFs, images, slides)
│   │   ├── pdfs/
│   │   ├── images/
│   │   └── slides/
│   ├── _pages/         # Website pages
│   ├── _publications/  # Papers
│   ├── _talks/         # Presentations
│   ├── _teaching/      # Courses
│   ├── _experience/    # Job history
│   ├── _education/     # Degrees
│   └── .obsidian/      # Obsidian config + templates
└── update-design.sh     # Safe update script
```

## Working with This Codebase

### Understanding Content State
The repository contains **example/placeholder content**:
- Generic academic profile ("Dr. Academic Name")
- Sample publications with fake DOIs
- Example talks and presentations
- Placeholder images and paths

**For users**: They replace all this with their real content.

### Modifying Design
When updating design elements:
1. ✅ **Safe to modify**: `_layouts/`, `assets/css/`, `_sass/`, `_plugins/`
2. ❌ **Don't modify**: Anything in `vault/` (except for examples)
3. ⚠️ **Careful with**: `_config.yml` (has both template and user settings)

### Adding Features
When adding new features:
1. **Design code** → Goes in `_layouts/`, `_plugins/`, or `assets/`
2. **Example content** → Add to `vault/` with clear placeholders
3. **Documentation** → Update README.md
4. **Update script** → Add new files to `DESIGN_FILES` array in `update-design.sh`

### Testing Changes
```bash
# Local development
bundle exec jekyll serve --host 127.0.0.1 --port 4000

# Build without serving
bundle exec jekyll build

# Test with trace (for debugging)
bundle exec jekyll build --trace
```

## Common Modifications

### Adding a New Page Type
1. Create layout in `_layouts/pagetype.html`
2. Add collection to `_config.yml`:
   ```yaml
   collections:
     pagetype:
       output: true
       permalink: /pagetype/:name/
   ```
3. Add default layout:
   ```yaml
   defaults:
     - scope:
         type: "pagetype"
       values:
         layout: "pagetype"
   ```
4. Create example in `vault/_pagetype/`
5. Add template to `vault/.obsidian/templates/`

### Updating Styles
1. Edit `assets/css/main.scss` for main styles
2. Use CSS custom properties for themes:
   ```scss
   :root {
     --primary-color: #value;
   }
   [data-theme="dark"] {
     --primary-color: #dark-value;
   }
   ```
3. Changes automatically apply to both themes

### Modifying Jekyll Plugins
- Plugin runs during `jekyll build` phase
- Must be in `_plugins/` directory
- Works locally and on GitHub Actions
- **Not** on GitHub Pages without Actions (safe mode)

## Important Paths

### Asset References
Users should reference assets as:
- PDFs: `/vault/assets/pdfs/filename.pdf`
- Images: `/vault/assets/images/photo.jpg`
- Slides: `/vault/assets/slides/presentation.pdf`

Design assets (favicon, etc.):
- CSS: `/assets/css/main.css` (auto-generated from SCSS)
- Images: `/assets/images/favicon.svg`

### URL Structure
- Homepage: `/`
- Pages: `/:name/` (e.g., `/cv/`, `/publications/`)
- Publications: `/publications/:name/`
- Talks: `/talks/:name/`
- Teaching: `/teaching/:name/`
- Experience: `/experience/:name/`

## Configuration Notes

### _config.yml Structure
```yaml
# User customizes these:
title: "User's Name"
email: user@email.com
profile_photo: "/vault/assets/images/photo.jpg"
github_username: username
orcid: 0000-0000-0000-0000

# Template provides these:
collections_dir: vault
collections: [...]
defaults: [...]
```

### Jekyll Build Settings
```yaml
markdown: kramdown
highlighter: rouge
plugins:
  - jekyll-feed
  - jekyll-sitemap
  - jekyll-seo-tag
include:
  - vault/assets  # Serve user content files
exclude:
  - vault/.obsidian/  # Hide Obsidian config
```

## Deployment

### GitHub Actions Workflow
Located at `.github/workflows/jekyll.yml`:
- Triggers on push to `main` or `master`
- Builds with full plugin support
- Deploys to GitHub Pages
- **This is why wikilinks work in production**

### Local vs Production
- **Local**: All features work with `jekyll serve`
- **Production**: Same features via GitHub Actions
- **GitHub Pages direct**: Custom plugins wouldn't work (hence Actions)

## Troubleshooting

### Wikilinks Not Converting
- Check `_plugins/obsidian_wikilinks.rb` exists
- Verify Jekyll is running (not cached HTML)
- Plugin runs before markdown processing

### Assets Not Found
- User content: Should be in `vault/assets/`
- Design assets: Should be in `assets/`
- Check paths in `_config.yml` → `include:` array

### Dark Theme Issues
- Check `[data-theme="dark"]` CSS rules
- Verify localStorage is enabled
- JavaScript in `_layouts/default.html`

### Build Errors
```bash
# Common fixes:
bundle install              # Update dependencies
bundle exec jekyll clean    # Clear cache
bundle exec jekyll build --trace  # Debug
```

## Update Strategy

### Version System
The template uses semantic versioning (MAJOR.MINOR.PATCH):
- **VERSION** file contains current version
- **CHANGELOG.md** documents all changes
- Update script checks versions automatically
- GitHub Actions can create PRs for updates

### For Template Maintainers
When releasing updates:
1. Modify design files (`_layouts/`, `assets/`, `_plugins/`)
2. Test with example content in `vault/`
3. **Update VERSION file** (e.g., `2.0.0` → `2.1.0`)
4. **Update CHANGELOG.md** with changes
5. Update `update-design.sh` if new files added
6. Document changes in README.md
7. Commit and push (users will be notified)

### For Users

**Manual Updates:**
```bash
./update-design.sh                # Interactive update
./update-design.sh --check-only   # Just check version
./update-design.sh --non-interactive  # For CI/CD
```

**Automatic Updates:**
Users can enable weekly update checks:
1. Uncomment schedule in `.github/workflows/template-update.yml`
2. GitHub Actions creates PRs automatically
3. Auto-merges if safe, requests review if conflicts

### Update Script Features
The `update-design.sh` script:
- Compares local vs remote VERSION
- Shows changelog excerpt
- Detects user modifications to design files
- Creates timestamped backups
- Outputs for GitHub Actions integration
- Supports non-interactive mode for CI/CD
- Migrates old structures automatically

### GitHub Actions Workflow
Located at `.github/workflows/template-update.yml`:
- Checks for updates (weekly or manual)
- Runs update script in non-interactive mode
- Detects conflicts with user customizations
- Creates PR with detailed information
- Enables auto-merge if safe
- Comments on PR with status

**Conflict Detection:**
- Checks if user has committed changes to design files
- Excludes commits with "template update" in message
- If conflicts: disables auto-merge, requests review
- If clean: enables auto-merge, merges automatically

## Known Considerations

### Obsidian Templates
Templates in `vault/.obsidian/templates/` use Templater syntax but with placeholders:
- `<% tp.file.creation_date() %>` - Templater plugin feature
- Users need Templater plugin installed in Obsidian
- Templates are just examples - users customize

### Pagination Deprecation
Warning appears: "pagination turned on without jekyll-paginate gem"
- Not actually used currently
- Remove from `_config.yml` or add gem if implementing blog

### Math in Markdown
MathJax processes after markdown:
- Use `$$` on separate lines for display mode
- Avoid `$` next to letters (escape if needed)
- Complex expressions may need `\text{}` wrapper

## Best Practices

### When Adding Examples
- Use generic names ("Dr. Academic Name")
- Include realistic but fake data
- Add comments explaining what users should change
- Link to actual working examples where possible

### When Modifying Layouts
- Keep responsive design principles
- Test with different content lengths
- Maintain accessibility (ARIA labels)
- Preserve print styles

### When Writing Documentation
- Assume users are academics, not developers
- Provide complete examples
- Explain both Obsidian and Jekyll sides
- Include troubleshooting steps

## Quick Reference Commands

```bash
# Development
bundle exec jekyll serve --host 127.0.0.1 --port 4000

# Build
bundle exec jekyll build

# Update design
./update-design.sh

# Check git status
git status

# Create commit
git add -A
git commit -m "Description"
git push
```

## Contact & Support
- GitHub Issues: For bug reports
- GitHub Discussions: For questions
- README.md: Comprehensive user guide
- USER_CONFIG.md: Customization guide

---

**Remember**: This is a template. Every change should consider: "Will this work when users customize their content?"