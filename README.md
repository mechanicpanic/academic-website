# Academic CV & Publication Website

A professional academic website built with Jekyll and optimized for seamless Obsidian integration. Features Computer Modern typography, responsive design, and complete content management through an Obsidian vault.

## 🌟 Features

- **Complete Obsidian Integration**: All content managed through Obsidian vault with automated Jekyll publishing
- **Academic Typography**: Professional Computer Modern fonts for that LaTeX-quality appearance
- **Responsive Design**: Mobile-first design with clean, academic aesthetics
- **Rich Content Types**: Dedicated collections for publications, experience, education, talks, and teaching
- **Automated Deployment**: GitHub Actions workflow for continuous deployment to GitHub Pages
- **SEO Optimized**: Built-in SEO tags, structured data, and RSS feeds
- **Professional Layout**: Header contact information, refined navigation, and print-friendly styles

## 🚀 Live Demo

**Website URL**: [https://mechanicpanic.github.io/academic-website/](https://mechanicpanic.github.io/academic-website/)

## 🚀 Quick Start (Template Usage)

### 1. Use This Template
1. Click the green **"Use this template"** button above
2. Create your new repository (e.g., `your-username/academic-website`)
3. Clone your new repository locally

### 2. Customize Your Site
1. **Edit `_config.yml`** - Add your name, email, social links
2. **Edit `vault/_pages/index.md`** - Write your bio
3. **Add content** using Obsidian or directly editing markdown files
4. **See `USER_CONFIG.md`** for detailed customization guide

### 3. Deploy
1. Push to GitHub
2. Enable GitHub Pages in repository Settings → Pages
3. Your site will be live at `https://your-username.github.io/your-repo-name/`

### 4. Keep Design Updated (Optional)
- **Manual**: Run `./update-design.sh` to get latest template improvements
- **Automatic**: Enable weekly update checks (see [Automatic Updates](#automatic-template-updates))
- Your content stays safe, only design files update

## 🏗️ Architecture

### Technology Stack
- **Static Site Generator**: Jekyll 4.3+
- **Content Management**: Obsidian vault with templates
- **Typography**: Computer Modern web fonts via CDN
- **Styling**: Modern SCSS with CSS custom properties
- **Deployment**: GitHub Actions + GitHub Pages
- **Version Control**: Git with automated CI/CD

### Project Structure
```
your-academic-website/              # Your repository from template
├── _config.yml                    # 🎯 YOUR SETTINGS - Edit this!
├── _layouts/                      # 🔧 Template files (updated via script)
│   ├── default.html              # Base layout with header/nav/footer
│   ├── publication.html          # Publication detail page
│   ├── experience.html           # Experience detail page
│   ├── talk.html                 # Talk detail page
│   └── teaching.html             # Teaching detail page
├── _plugins/                     # 🔧 Jekyll plugins (Obsidian links, etc.)
├── assets/                       # 🎨 DESIGN ASSETS ONLY
│   ├── css/main.scss            # Styles (customize colors here)
│   └── images/                  # Design images (favicon, etc.)
├── Gemfile                       # Ruby dependencies
├── vault/                        # 📝 YOUR CONTENT - All yours!
│   ├── assets/                  # 📁 YOUR FILES - Managed in Obsidian
│   │   ├── pdfs/               # 📄 Your PDF files
│   │   ├── images/             # 🖼️ Your images & photos
│   │   └── slides/             # 📊 Your presentation slides
│   ├── _pages/                  # Website pages
│   │   ├── index.md            # 📝 Homepage - Write your bio here
│   │   ├── cv.md               # 📝 Your CV page
│   │   ├── publications.md      # Publications listing page
│   │   ├── research.md         # Research overview page
│   │   ├── teaching.md         # Teaching portfolio page
│   │   ├── talks.md            # Talks & presentations page
│   │   └── contact.md          # Contact information page
│   ├── _publications/          # 📝 Add your papers here
│   ├── _experience/            # 📝 Add your work experience
│   ├── _education/             # 📝 Add your degrees
│   ├── _talks/                 # 📝 Add your presentations
│   ├── _teaching/              # 📝 Add your courses
│   └── .obsidian/              # Obsidian configuration
│       └── templates/          # Content creation templates
├── .github/workflows/jekyll.yml # 🔧 Automated deployment
├── update-design.sh            # 🔄 Design update script
├── USER_CONFIG.md              # 📚 Your customization guide
└── README.md                   # This documentation
```

**Legend:**
- 📝 **YOUR CONTENT** - Edit freely, these are your files in `vault/`
- 📁 **YOUR FILES** - PDFs, images, slides managed in Obsidian (`vault/assets/`)
- 🎯 **YOUR SETTINGS** - Customize for your site
- 🎨 **DESIGN ASSETS** - CSS and design images (stay in `assets/`)
- 🔧 **TEMPLATE FILES** - Updated via `update-design.sh`
- 🔄 **UPDATE TOOLS** - Keep your design current

**Key Separation:**
- `vault/assets/` - Your content files (PDFs, images, slides) - managed in Obsidian
- `assets/` - Design files (CSS, favicon) - not in Obsidian

## 🎯 Getting Started

### Prerequisites
- [Ruby](https://www.ruby-lang.org/) 3.2+
- [Bundler](https://bundler.io/)
- [Obsidian](https://obsidian.md/) (for content management)
- [Git](https://git-scm.com/)

### Installing Ruby on macOS (Recommended Method)

**⚠️ Important**: Don't use the system Ruby that comes with macOS! It can cause permission issues and path conflicts.

#### Option 1: Homebrew (Simplest)

1. **Install Homebrew** (if not already installed):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install Ruby via Homebrew**:
   ```bash
   brew install ruby
   ```

3. **Add Homebrew Ruby to your PATH**:
   Add this to your `~/.zshrc` (or `~/.bash_profile` if using bash):
   ```bash
   export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
   export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
   export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
   export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"
   ```

4. **Reload your shell**:
   ```bash
   source ~/.zshrc
   ```

5. **Verify installation**:
   ```bash
   which ruby
   # Should show: /opt/homebrew/opt/ruby/bin/ruby
   ruby -v
   # Should show: ruby 3.x.x
   ```

#### Option 2: rbenv (Most Flexible)

1. **Install rbenv via Homebrew**:
   ```bash
   brew install rbenv ruby-build
   ```

2. **Initialize rbenv**:
   ```bash
   rbenv init
   ```

3. **Add rbenv to your shell** (add to `~/.zshrc`):
   ```bash
   eval "$(rbenv init - zsh)"
   ```

4. **Install and set Ruby version**:
   ```bash
   rbenv install 3.2.0
   rbenv global 3.2.0
   ```

5. **Verify installation**:
   ```bash
   which ruby
   # Should show: /Users/yourusername/.rbenv/shims/ruby
   ruby -v
   # Should show: ruby 3.2.0
   ```

#### Installing Bundler

After installing Ruby with either method:
```bash
gem install bundler
```

#### Troubleshooting Ruby Installation

**If you see permission errors**:
- ❌ **Don't use `sudo`** with gem commands
- ✅ **Use Homebrew or rbenv** as described above

**If `bundle install` fails**:
```bash
# Set bundle to install gems locally
bundle config set --local path 'vendor/bundle'
bundle install
```

**Check your Ruby setup**:
```bash
# Verify you're not using system Ruby
which ruby
# Should NOT show: /usr/bin/ruby

# Check gem environment
gem env
# Look for paths under /opt/homebrew or ~/.rbenv
```

### Local Development

1. **Use this template to create your repository**
   - Click "Use this template" button
   - Clone YOUR new repository locally

2. **Install Jekyll dependencies**
   ```bash
   cd your-academic-website
   bundle install
   ```

3. **Customize your site**
   ```bash
   # Edit your basic settings
   nano _config.yml
   
   # Edit your homepage bio
   nano vault/_pages/index.md
   ```

4. **Run local development server**
   ```bash
   bundle exec jekyll serve --host 127.0.0.1 --port 4000
   ```

5. **View the site**
   Open [http://127.0.0.1:4000](http://127.0.0.1:4000) in your browser

### Content Management with Obsidian

1. **Open Obsidian**
2. **Open vault**: Point to `your-academic-website/vault/`
3. **Use templates**: Cmd/Ctrl+P → "Templater: Create new note from template"
4. **Available templates**:
   - Publication.md - Research papers and publications
   - Experience.md - Professional positions
   - Education.md - Academic degrees
   - Talk.md - Presentations and seminars
   - Teaching.md - Courses and educational activities
   - Page.md - General website pages

**💡 Pro tip**: All your content lives in the `vault/` directory, making it easy to manage everything through Obsidian while keeping design updates separate!

#### Obsidian Wikilinks Support

This template fully supports Obsidian-style wikilinks:

- ✅ **Basic links**: `[[Page Name]]` → links to page
- ✅ **Custom text**: `[[Page Name|Display Text]]` → shows "Display Text"
- ✅ **Works with all content**: pages, publications, talks, etc.
- ✅ **Works locally**: Full support with `jekyll serve` and in production

Example:
```markdown
Check out my [[Publications]] or read about my [[Research|research interests]].
See my recent talk on [[The Future of AI: Scalable and Sustainable Machine Learning|sustainable AI]].
```

## 📝 Content Creation Workflow

### Adding a New Publication

1. In Obsidian: Cmd/Ctrl+P → "Templater: Create new note from template"
2. Select "Publication" template
3. Fill in the front matter:
   ```yaml
   ---
   layout: publication
   title: "Your Paper Title"
   date: 2024-01-15
   year: 2024
   authors:
     - "Your Name"
     - "Co-author Name"
   venue: "Conference/Journal Name"
   type: "conference"
   status: "published"
   abstract: |
     Brief description of your research...
   keywords:
     - "keyword1"
     - "keyword2"
   doi: "10.1000/123456"
   arxiv: "2401.12345"
   pdf: "/vault/assets/pdfs/paper.pdf"
   code: "https://github.com/user/repo"
   ---
   ```
4. Save in `vault/_publications/` directory
5. Add PDF to `vault/assets/pdfs/` if you have one
6. Jekyll automatically rebuilds the site

### Managing Files in Obsidian

All your content files are in the `vault/` directory, making them accessible in Obsidian:

#### Adding PDFs
1. Copy your PDF to `vault/assets/pdfs/`
2. Reference it in your markdown: `pdf: "/vault/assets/pdfs/filename.pdf"`

#### Adding Images
1. Copy images to `vault/assets/images/`
2. Use in markdown: `![Description](/vault/assets/images/photo.jpg)`
3. For profile photo: Update path in `_config.yml`

#### Adding Slides
1. Copy presentation files to `vault/assets/slides/`
2. Link in talks: `slides: "/vault/assets/slides/presentation.pdf"`

**Note**: All files in `vault/assets/` are:
- ✅ Visible and manageable in Obsidian
- ✅ Automatically served by Jekyll at `/vault/assets/...`
- ✅ Preserved during design updates
- ✅ Part of your content, not the template

### Updating Site Configuration

Edit `academic-website/docs/_config.yml`:
```yaml
title: "Your Name"
subtitle: "Your Position"
email: your.email@university.edu
orcid: 0000-0000-0000-0000
scholar: your_scholar_id
github_username: your_username
linkedin: your_linkedin
```

## 🎨 Customization

### Colors and Typography

Edit `academic-website/docs/assets/css/main.scss`:
```scss
:root {
  --primary-text: #2d3748;      // Dark gray-blue
  --secondary-text: #4a5568;    // Medium gray
  --accent-color: #5a67d8;      // Muted indigo
  --background: #ffffff;        // Pure white
  --surface: #f7fafc;          // Very light gray
}
```

### Layout Modifications

- **Header**: `academic-website/docs/_layouts/default.html`
- **Publication display**: `academic-website/docs/_layouts/publication.html`
- **Page structure**: Individual layout files in `_layouts/`

## 🚀 Deployment

### Automatic Deployment (Recommended)

The site automatically deploys to GitHub Pages via GitHub Actions:

1. **Push changes** to the `master` branch
2. **GitHub Actions** builds the Jekyll site with custom plugins enabled
3. **Deploys** to `https://yourusername.github.io/academic-website/`

**Important**: The GitHub Actions workflow enables custom Jekyll plugins, which means:
- ✅ Obsidian wikilinks (`[[Page Name]]`) work automatically
- ✅ LaTeX math rendering with MathJax
- ✅ All custom features are supported
- ✅ No manual build required

### Manual Deployment

```bash
cd academic-website/docs
bundle exec jekyll build
# Upload _site/ directory to your web server
```

## 🔄 Keeping the Template Updated

The template receives regular updates with new features, bug fixes, and improvements. You can stay current in two ways:

### Manual Updates

Run the update script whenever you want:

```bash
./update-design.sh
```

**What it does:**
- ✅ Checks your current version vs latest
- ✅ Shows changelog of what's new
- ✅ Detects if you've customized design files
- ✅ Updates only template files, preserves your content
- ✅ Creates timestamped backup
- ✅ Migrates old structures automatically

**Options:**
```bash
./update-design.sh --help             # Show all options
./update-design.sh --check-only       # Just check, don't update
./update-design.sh --force            # Force update
```

### Automatic Template Updates

**Recommended for hassle-free maintenance!**

The template includes a GitHub Actions workflow that can automatically check for updates and create PRs.

#### Enable Automatic Updates

1. **Edit `.github/workflows/template-update.yml`**
2. **Uncomment the schedule trigger:**
   ```yaml
   schedule:
     - cron: '0 0 * * 0'  # Weekly on Sunday
   ```
3. **Commit and push**

That's it! The workflow will now:
- ✅ Check weekly for template updates
- ✅ Create a PR when updates are available
- ✅ Show changelog and what changed
- ✅ Auto-merge if safe (no conflicts)
- ✅ Request review if you've customized design files

#### How It Works

**When you haven't customized design files:**
- PR is created automatically
- Auto-merge is enabled
- PR merges itself after checks pass
- Your site is updated seamlessly

**When you have customized design files:**
- PR is created for your review
- Shows which files conflict
- Auto-merge is disabled
- You review and merge when ready

#### Manual Trigger

You can also trigger updates manually:
1. Go to **Actions** tab in your repository
2. Select **Check for Template Updates**
3. Click **Run workflow**
4. Optionally enable "Force update"

### Version Information

Check your current version:
```bash
cat VERSION
```

View changelog:
```bash
cat CHANGELOG.md
```

Or visit the [template repository](https://github.com/mechanicpanic/academic-website) for the latest changes.

### What Gets Updated

**Updated files** (design/template):
- `_layouts/` - HTML templates
- `_plugins/` - Jekyll plugins
- `assets/css/` - Stylesheets
- `.github/workflows/` - GitHub Actions
- `update-design.sh` - Update script itself
- `VERSION` and `CHANGELOG.md`

**Preserved files** (your content):
- `vault/` - All your content and files
- `_config.yml` - Your configuration
- `Gemfile.lock` - Your dependencies
- All backups in `.design-backup/`

### Conflict Resolution

If you've customized design files and an update conflicts:

1. **Review the PR** - See what changed in the template
2. **Test locally** - Checkout the branch and test:
   ```bash
   git fetch
   git checkout template-update-XXXXXXXX
   bundle exec jekyll serve
   ```
3. **Merge conflicts** - Resolve any conflicts manually
4. **Merge the PR** - Once satisfied, merge it

The update script creates backups, so you can always revert:
```bash
# Revert to backup
cp -r .design-backup/YYYYMMDD_HHMMSS/* .
```

## 🔧 Advanced Features

### How Obsidian Wikilinks Work

The template includes a custom Jekyll plugin (`_plugins/obsidian_wikilinks.rb`) that:
1. Scans all markdown files for `[[wikilink]]` patterns
2. Converts them to proper markdown links before Jekyll processes them
3. Automatically finds the correct URL for each linked page

**Features**:
- Works both locally (`jekyll serve`) and in production (GitHub Actions)
- No setup needed - plugin is included and ready to use
- Automatically resolves page titles to URLs
- Supports all content types: pages, publications, talks, etc.

### Custom Domain Setup

1. Add `CNAME` file to root directory:
   ```
   yourdomain.com
   ```
2. Configure DNS to point to GitHub Pages
3. Enable HTTPS in repository settings

### Analytics Integration

Add to `_config.yml`:
```yaml
google_analytics: "G-XXXXXXXXXX"
```

### PDF CV Generation

The site includes print-optimized CSS for generating PDF versions of your CV directly from the browser.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🆘 Support

- **Documentation**: Check the comprehensive guides in this README
- **Issues**: Report bugs and request features via [GitHub Issues](https://github.com/mechanicpanic/academic-website/issues)
- **Discussions**: Join conversations in [GitHub Discussions](https://github.com/mechanicpanic/academic-website/discussions)

## 🙏 Acknowledgments

- **Jekyll**: Static site generator that powers the website
- **Obsidian**: Outstanding note-taking app that enables seamless content management
- **Computer Modern Fonts**: Beautiful typography courtesy of [dreampulse/computer-modern-web-font](https://github.com/dreampulse/computer-modern-web-font)
- **GitHub Pages**: Free hosting for academic websites

---

**Built with ❤️ for the academic community**

*Creating beautiful, maintainable academic websites should be simple. This template provides everything you need to showcase your research and professional work with the elegance of LaTeX typography and the convenience of modern web technologies.*