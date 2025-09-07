#!/bin/bash

# Academic Website Template - Design Update Script
# This script updates design files while preserving your content
# Version: 2.0 - Now with backward compatibility and migration support

set -e

echo "🎨 Academic Website Design Updater v2.0"
echo "========================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ Error: This script must be run from the root of your git repository${NC}"
    exit 1
fi

# Check if there are uncommitted changes
if ! git diff --quiet || ! git diff --cached --quiet; then
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
fi

# Detect if user has old structure (assets in vault/)
NEEDS_MIGRATION=false
if [ -d "vault/assets" ] && [ ! -d "assets" ]; then
    echo -e "${YELLOW}📁 Detected old structure with assets in vault/...${NC}"
    NEEDS_MIGRATION=true
elif [ -d "vault/assets" ] && [ -d "assets" ]; then
    echo -e "${YELLOW}⚠️  Found both vault/assets/ and assets/ directories${NC}"
    echo "This might indicate a partial migration."
    read -p "Should we merge vault/assets/ into assets/? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        NEEDS_MIGRATION=true
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
        # Only process if file contains vault/assets references
        if grep -q "/vault/assets" "$file" 2>/dev/null; then
            echo "    Fixing paths in: $file"
            if [[ "$OSTYPE" == "darwin"* ]]; then
                # macOS sed syntax
                sed -i '' 's|/vault/assets|/assets|g' "$file"
            else
                # Linux sed syntax
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
    
    echo -e "${GREEN}✅ Migration completed!${NC}"
    echo ""
fi

echo -e "${BLUE}📦 Downloading latest template...${NC}"

# Create temporary directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download latest template
if ! curl -L "https://github.com/mechanicpanic/academic-website/archive/master.zip" -o template.zip; then
    echo -e "${RED}❌ Failed to download template${NC}"
    exit 1
fi

# Extract template
if ! unzip -q template.zip; then
    echo -e "${RED}❌ Failed to extract template${NC}"
    exit 1
fi

cd academic-website-master

# Go back to original directory
cd "$OLDPWD"

echo -e "${YELLOW}🔄 Updating design files...${NC}"

# Files to update (design/template files only)
# IMPORTANT: We preserve user content and configuration
DESIGN_FILES=(
    "_layouts"
    "_includes" 
    "_sass"
    "assets/css/main.scss"
    ".github/workflows"
    "update-design.sh"
    "_plugins"  # Added plugins directory for Obsidian link support
)

# Files to never overwrite (user content)
PRESERVE_FILES=(
    "_config.yml"
    "vault"              # All user content including vault/assets
    ".design-backup"
    ".migration-backup"
    "Gemfile.lock"       # Preserve their dependencies
)

# Backup current design files
echo -e "${BLUE}💾 Creating backup...${NC}"
BACKUP_DIR=".design-backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

for file in "${DESIGN_FILES[@]}"; do
    if [ -e "$file" ]; then
        # Create parent directory in backup if needed
        mkdir -p "$BACKUP_DIR/$(dirname "$file")" 2>/dev/null || true
        cp -r "$file" "$BACKUP_DIR/$(dirname "$file")/" 2>/dev/null || true
    fi
done

# Save current version info
echo "Updated from: $(git rev-parse HEAD 2>/dev/null || echo 'unknown')" > "$BACKUP_DIR/version.txt"
date >> "$BACKUP_DIR/version.txt"

# Update design files
for file in "${DESIGN_FILES[@]}"; do
    if [ -e "$TEMP_DIR/academic-website-master/$file" ]; then
        echo "  Updating $file"
        # Create parent directory if needed
        mkdir -p "$(dirname "$file")" 2>/dev/null || true
        rm -rf "$file" 2>/dev/null || true
        cp -r "$TEMP_DIR/academic-website-master/$file" "$file"
    fi
done

# Handle special files that might not exist in old versions
# Copy new example files if they don't exist (but don't overwrite)
NEW_OPTIONAL_FILES=(
    "README.md"
    "USER_CONFIG.md"
)

for file in "${NEW_OPTIONAL_FILES[@]}"; do
    if [ ! -e "$file" ] && [ -e "$TEMP_DIR/academic-website-master/$file" ]; then
        echo "  Adding new file: $file"
        cp "$TEMP_DIR/academic-website-master/$file" "$file"
    fi
done

# Clean up
rm -rf "$TEMP_DIR"

echo ""
echo -e "${GREEN}✅ Design files updated successfully!${NC}"
echo ""

# Check if Jekyll can build
echo -e "${BLUE}🔍 Checking Jekyll configuration...${NC}"
if bundle exec jekyll build --dry-run > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Jekyll configuration looks good!${NC}"
else
    echo -e "${YELLOW}⚠️  Jekyll build check failed. You may need to:${NC}"
    echo "   1. Run: bundle install"
    echo "   2. Check for missing dependencies"
fi

echo ""
echo -e "${YELLOW}📋 Next steps:${NC}"
echo "1. Review changes: git diff"
echo "2. Test your site: bundle exec jekyll serve"
echo "3. If everything looks good: git add . && git commit -m 'Update design from template'"
echo "4. If you need to revert: cp -r $BACKUP_DIR/* ."
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
fi