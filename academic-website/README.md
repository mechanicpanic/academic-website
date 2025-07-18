# Academic CV & Publication Website

A Jekyll-based academic website with seamless Obsidian integration, featuring Computer Modern typography and refined aesthetics for managing academic content.

## Features

- **Obsidian Integration**: Complete content management through Obsidian with automated Jekyll publishing
- **Academic Collections**: Organized content types for publications, experience, education, talks, and teaching
- **Computer Modern Typography**: Professional academic typography with web-optimized Computer Modern fonts
- **Responsive Design**: Mobile-first design with clean, academic aesthetics
- **Automated Deployment**: GitHub Actions workflow for continuous deployment
- **Rich Metadata**: Structured data for publications, talks, and academic content
- **SEO Optimized**: Built-in SEO tags and structured data for academic content

## Quick Start

### 1. Setup Repository

```bash
# Clone this repository
git clone [repository-url]
cd academic-website

# Initialize as Git repository (if needed)
git init
```

### 2. Install Jekyll

```bash
cd docs/
bundle install
```

### 3. Configure Site

Edit `docs/_config.yml`:

```yaml
title: "Your Name"
subtitle: "Your Title"
email: your.email@university.edu
# Update social links and academic information
```

### 4. Setup Obsidian

1. Open Obsidian
2. Open the `docs/vault/` folder as a vault
3. Install the Templater plugin for automated templates
4. Configure templates folder: `.obsidian/templates/`

### 5. Local Development

```bash
cd docs/
bundle exec jekyll serve
```

Visit `http://localhost:4000` to see your site.

## Content Management with Obsidian

### Adding Publications

1. In Obsidian, use Cmd/Ctrl+P → "Templater: Create new note from template"
2. Select "Publication" template
3. Fill in the front matter with publication details
4. Add detailed content in the body

### Adding Other Content

Use the provided templates for:
- **Experience**: Professional and academic positions
- **Education**: Degrees and academic credentials
- **Talks**: Presentations and conference talks
- **Teaching**: Courses and educational activities

### File Organization

```
vault/
├── _publications/     # Research papers and publications
├── _experience/       # Professional experience
├── _education/        # Academic degrees
├── _projects/         # Research projects
├── _talks/            # Presentations and talks
├── _teaching/         # Teaching activities
└── pages/             # Static pages
```

## Deployment

### GitHub Pages (Automatic)

1. Push to GitHub repository
2. Enable GitHub Pages in repository settings
3. GitHub Actions will automatically build and deploy

### Manual Deployment

```bash
cd docs/
bundle exec jekyll build
# Upload _site/ directory to your web server
```

## Customization

### Colors and Typography

Edit `docs/_sass/main.scss` to customize:
- Color palette (CSS custom properties in `:root`)
- Typography settings
- Layout spacing and sizing

### Layouts

Modify layouts in `docs/_layouts/` to customize:
- Page structure and navigation
- Content presentation
- Metadata display

### Content Types

Add new collections in `docs/_config.yml`:

```yaml
collections:
  new_collection:
    output: true
    permalink: /new_collection/:name/
```

## Advanced Features

### BibTeX Integration

Publications support full BibTeX metadata and automatic citation formatting.

### PDF Generation

Configure CV PDF generation by adding LaTeX/Pandoc workflow to GitHub Actions.

### Search

Implement client-side search using Jekyll plugins or JavaScript libraries.

## Obsidian Plugins (Recommended)

- **Templater**: Automated content creation with templates
- **Calendar**: Date-based content organization
- **Tag Wrangler**: Tag management for academic topics
- **Citations**: Integration with reference managers

## Troubleshooting

### Common Issues

1. **Jekyll Build Errors**: Check `docs/_config.yml` syntax
2. **Missing Fonts**: Verify Computer Modern CDN connection
3. **Obsidian Sync**: Ensure `.obsidian` folder is included in Git (already configured)

### Support

- Jekyll Documentation: https://jekyllrb.com/docs/
- Obsidian Documentation: https://help.obsidian.md/
- Computer Modern Fonts: https://github.com/dreampulse/computer-modern-web-font

## License

This template is open source and available under the MIT License. The Computer Modern fonts are available under the SIL Open Font License.

---

Built with ❤️ for the academic community. Contributions welcome!