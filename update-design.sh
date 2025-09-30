#!/bin/bash

# Academic Website Template - Design Update Script
# This script updates design files while preserving your content
# Version: 2.1 - Added version checking and GitHub Actions support

set -e

# Default values
NON_INTERACTIVE=false
CHECK_ONLY=false
FORCE_UPDATE=false
TEMPLATE_URL="https://github.com/mechanicpanic/academic-website"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --non-interactive)
      NON_INTERACTIVE=true
      shift
      ;;
    --check-only)
      CHECK_ONLY=true
      shift
      ;;
    --force)
      FORCE_UPDATE=true
      shift
      ;;
    --help)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --non-interactive    Run without user prompts (for CI/CD)"
      echo "  --check-only         Only check for updates, don't apply"
      echo "  --force              Force update even if no changes"
      echo "  --help               Show this help message"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
done

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Disable colors in non-interactive mode
if [ "$NON_INTERACTIVE" = true ]; then
  RED=''
  GREEN=''
  YELLOW=''
  BLUE=''
  NC=''
fi

echo "🎨 Academic Website Design Updater v2.1"
echo "========================================"
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Error: This script must be run from the root of your git repository${NC}"
    exit 1
fi

# Function to get current local version
get_local_version() {
    if [ -f "VERSION" ]; then
        cat VERSION
    else
        echo "unknown"
    fi
}

# Function to get remote version
get_remote_version() {
    curl -s "https://raw.githubusercontent.com/mechanicpanic/academic-website/master/VERSION" || echo "unknown"
}

# Function to compare versions
version_greater_than() {
    # Returns 0 if $1 > $2
    [ "$1" = "$(echo -e "$1\n$2" | sort -V | tail -n1)" ] && [ "$1" != "$2" ]
}

# Function to check for user modifications to design files
check_user_modifications() {
    local modified_files=""
    local design_files=("_layouts" "_sass" "assets/css/main.scss" "_plugins")

    for file in "${design_files[@]}"; do
        if [ -e "$file" ]; then
            # Check if user has commits to this file (excluding template updates)
            if git log --all --oneline -- "$file" 2>/dev/null | grep -v "Update design from template" | grep -v "template update" > /dev/null; then
                modified_files="$modified_files $file"
            fi
        fi
    done

    echo "$modified_files"
}

# Check versions
LOCAL_VERSION=$(get_local_version)
REMOTE_VERSION=$(get_remote_version)

echo "Current version: $LOCAL_VERSION"
echo "Latest version:  $REMOTE_VERSION"
echo ""

# Check if update is available
if [ "$REMOTE_VERSION" = "unknown" ]; then
    echo -e "${YELLOW}⚠️  Could not check remote version${NC}"
    if [ "$CHECK_ONLY" = true ]; then
        exit 1
    fi
elif [ "$LOCAL_VERSION" = "$REMOTE_VERSION" ] && [ "$FORCE_UPDATE" = false ]; then
    echo -e "${GREEN}✅ You are already on the latest version${NC}"
    if [ "$CHECK_ONLY" = true ]; then
        exit 0
    fi
    if [ "$NON_INTERACTIVE" = false ]; then
        read -p "Continue with update anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Update cancelled."
            exit 0
        fi
    else
        echo "No update needed."
        exit 0
    fi
elif version_greater_than "$REMOTE_VERSION" "$LOCAL_VERSION"; then
    echo -e "${BLUE}🆕 New version available!${NC}"

    # Try to get changelog
    CHANGELOG=$(curl -s "https://raw.githubusercontent.com/mechanicpanic/academic-website/master/CHANGELOG.md" | sed -n "/## \[$REMOTE_VERSION\]/,/## \[/p" | sed '$d')
    if [ -n "$CHANGELOG" ]; then
        echo ""
        echo -e "${YELLOW}What's new:${NC}"
        echo "$CHANGELOG"
        echo ""
    fi
fi

# If check-only mode, exit here
if [ "$CHECK_ONLY" = true ]; then
    # Output for GitHub Actions
    if [ "$NON_INTERACTIVE" = true ]; then
        echo "::set-output name=update_available::true"
        echo "::set-output name=current_version::$LOCAL_VERSION"
        echo "::set-output name=latest_version::$REMOTE_VERSION"
    fi
    exit 0
fi

# Check for user modifications
USER_MODS=$(check_user_modifications)
if [ -n "$USER_MODS" ]; then
    echo -e "${YELLOW}⚠️  Detected user modifications to design files:${NC}"
    echo "$USER_MODS"
    echo ""
    if [ "$NON_INTERACTIVE" = true ]; then
        echo "::set-output name=has_conflicts::true"
        echo "::set-output name=modified_files::$USER_MODS"
    else
        read -p "Continue? Changes may conflict with your customizations (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Update cancelled."
            exit 1
        fi
    fi
else
    echo -e "${GREEN}✅ No user modifications detected - safe to auto-update${NC}"
    if [ "$NON_INTERACTIVE" = true ]; then
        echo "::set-output name=has_conflicts::false"
    fi
fi

# Check if there are uncommitted changes
if ! git diff --quiet || ! git diff --cached --quiet; then
    if [ "$NON_INTERACTIVE" = false ]; then
        echo -e "${YELLOW}⚠️  Warning: You have uncommitted changes.${NC}"
        echo "Please commit your changes before updating the design."
        echo ""
        echo "Current status:"
        git status --short
        echo ""
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Update cancelled."
            exit 1
        fi
    else
        echo "Uncommitted changes detected - will create commit"
    fi
fi

# Detect if user has old structure (assets in vault/)
NEEDS_MIGRATION=false
if [ -d "vault/assets" ] && [ ! -d "assets" ]; then
    echo -e "${YELLOW}📁 Detected old structure with assets in vault/...${NC}"
    NEEDS_MIGRATION=true
elif [ -d "vault/assets" ] && [ -d "assets" ]; then
    if [ "$NON_INTERACTIVE" = false ]; then
        echo -e "${YELLOW}⚠️  Found both vault/assets/ and assets/ directories${NC}"
        echo "This might indicate a partial migration."
        read -p "Should we merge vault/assets/ into assets/? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            NEEDS_MIGRATION=true
        fi
    fi
fi

# Perform migration if needed
if [ "$NEEDS_MIGRATION" = true ]; then
    echo -e "${BLUE}🔄 Migrating assets from vault/ to root...${NC}"

    # Backup current state
    echo "  Creating migration backup..."
    mkdir -p .migration-backup
    [ -d "assets" ] && cp -r assets .migration-backup/
    [ -d "vault/assets" ] && cp -r vault/assets .migration-backup/vault-assets

    # Move or merge assets
    if [ ! -d "assets" ]; then
        echo "  Moving vault/assets to assets..."
        mv vault/assets assets
    else
        echo "  Merging vault/assets into assets..."
        cp -r vault/assets/* assets/ 2>/dev/null || true
        rm -rf vault/assets
    fi

    # Update paths in content files
    echo "  Updating asset paths in content files..."

    # Fix paths in all markdown files in vault
    find vault -name "*.md" -type f | while read -r file; do
        if grep -q "/vault/assets" "$file" 2>/dev/null; then
            echo "    Fixing paths in: $file"
            if [[ "$OSTYPE" == "darwin"* ]]; then
                sed -i '' 's|/vault/assets|/assets|g' "$file"
            else
                sed -i 's|/vault/assets|/assets|g' "$file"
            fi
        fi
    done

    # Fix paths in _config.yml if needed
    if grep -q "/vault/assets" "_config.yml" 2>/dev/null; then
        echo "  Updating paths in _config.yml..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' 's|/vault/assets|/assets|g' "_config.yml"
        else
            sed -i 's|/vault/assets|/assets|g' "_config.yml"
        fi
    fi

    # Fix paths in layouts if needed
    if [ -d "_layouts" ]; then
        for layout in _layouts/*.html; do
            if [ -f "$layout" ] && grep -q "/vault/assets" "$layout" 2>/dev/null; then
                echo "  Updating paths in: $layout"
                if [[ "$OSTYPE" == "darwin"* ]]; then
                    sed -i '' 's|/vault/assets|/assets|g' "$layout"
                else
                    sed -i 's|/vault/assets|/assets|g' "$layout"
                fi
            fi
        done
    fi

    echo -e "${GREEN}✅ Migration completed!${NC}"
    echo ""
fi

echo -e "${BLUE}📦 Downloading latest template...${NC}"

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download latest template
if ! curl -L "$TEMPLATE_URL/archive/master.zip" -o template.zip 2>/dev/null; then
    echo -e "${RED}❌ Failed to download template${NC}"
    cd "$OLDPWD"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Extract template
if ! unzip -q template.zip 2>/dev/null; then
    echo -e "${RED}❌ Failed to extract template${NC}"
    cd "$OLDPWD"
    rm -rf "$TEMP_DIR"
    exit 1
fi

cd academic-website-master

# Go back to original directory
cd "$OLDPWD"

echo -e "${YELLOW}🔄 Updating design files...${NC}"

# Files to update (design/template files only)
DESIGN_FILES=(
    "_layouts"
    "_includes"
    "_sass"
    "assets/css/main.scss"
    ".github/workflows"
    "update-design.sh"
    "_plugins"
    "Gemfile"
    "VERSION"
    "CHANGELOG.md"
)

# Files to never overwrite (user content)
PRESERVE_FILES=(
    "_config.yml"
    "vault"
    ".design-backup"
    ".migration-backup"
    "Gemfile.lock"
)

# Backup current design files
echo -e "${BLUE}💾 Creating backup...${NC}"
BACKUP_DIR=".design-backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

for file in "${DESIGN_FILES[@]}"; do
    if [ -e "$file" ]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$file")" 2>/dev/null || true
        cp -r "$file" "$BACKUP_DIR/$(dirname "$file")/" 2>/dev/null || true
    fi
done

# Save current version info
echo "Updated from: $(git rev-parse HEAD 2>/dev/null || echo 'unknown')" > "$BACKUP_DIR/version.txt"
echo "Old version: $LOCAL_VERSION" >> "$BACKUP_DIR/version.txt"
echo "New version: $REMOTE_VERSION" >> "$BACKUP_DIR/version.txt"
date >> "$BACKUP_DIR/version.txt"

# Update design files
UPDATED_FILES=()
for file in "${DESIGN_FILES[@]}"; do
    if [ -e "$TEMP_DIR/academic-website-master/$file" ]; then
        echo "  Updating $file"
        mkdir -p "$(dirname "$file")" 2>/dev/null || true
        rm -rf "$file" 2>/dev/null || true
        cp -r "$TEMP_DIR/academic-website-master/$file" "$file"
        UPDATED_FILES+=("$file")
    fi
done

# Handle special files that might not exist in old versions
NEW_OPTIONAL_FILES=(
    "README.md"
    "USER_CONFIG.md"
)

for file in "${NEW_OPTIONAL_FILES[@]}"; do
    if [ ! -e "$file" ] && [ -e "$TEMP_DIR/academic-website-master/$file" ]; then
        echo "  Adding new file: $file"
        cp "$TEMP_DIR/academic-website-master/$file" "$file"
        UPDATED_FILES+=("$file")
    fi
done

# Clean up
rm -rf "$TEMP_DIR"

echo ""
echo -e "${GREEN}✅ Design files updated successfully!${NC}"
echo ""

# Output for GitHub Actions
if [ "$NON_INTERACTIVE" = true ]; then
    echo "::set-output name=updated::true"
    echo "::set-output name=files::${UPDATED_FILES[*]}"
fi

# Check if Jekyll can build (skip in CI to save time)
if [ "$NON_INTERACTIVE" = false ]; then
    echo -e "${BLUE}🔍 Checking Jekyll configuration...${NC}"
    if command -v bundle &> /dev/null && bundle exec jekyll build --dry-run > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Jekyll configuration looks good!${NC}"
    else
        echo -e "${YELLOW}⚠️  Jekyll build check skipped or failed${NC}"
        echo "   Run 'bundle install' and test manually"
    fi
fi

echo ""
echo -e "${YELLOW}📋 Next steps:${NC}"
if [ "$NON_INTERACTIVE" = true ]; then
    echo "1. Changes have been applied"
    echo "2. Review the diff in the PR"
    echo "3. Test locally if needed: bundle exec jekyll serve"
else
    echo "1. Review changes: git diff"
    echo "2. Test your site: bundle exec jekyll serve"
    echo "3. If everything looks good: git add . && git commit -m 'Update design to v$REMOTE_VERSION'"
    echo "4. If you need to revert: cp -r $BACKUP_DIR/* ."
fi
echo ""
echo -e "${BLUE}💡 Preserved:${NC}"
echo "   • Your content in vault/ (including vault/assets/)"
echo "   • Your configuration in _config.yml"
echo "   • Design assets remain in assets/"
echo "   • Backup saved in $BACKUP_DIR"
echo ""

# Migration notice
if [ "$NEEDS_MIGRATION" = true ]; then
    echo -e "${YELLOW}📝 Migration Notes:${NC}"
    echo "   • Assets have been moved from vault/assets/ to assets/"
    echo "   • All paths have been updated automatically"
    echo "   • Old structure backed up in .migration-backup/"
    echo "   • Please test thoroughly before committing"
    echo ""
fi

# Show what changed
if [ ${#UPDATED_FILES[@]} -gt 0 ]; then
    echo -e "${BLUE}📝 Updated files:${NC}"
    for file in "${UPDATED_FILES[@]}"; do
        echo "   • $file"
    done
fi