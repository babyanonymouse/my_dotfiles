`#!/bin/bash
# setup_sddm.sh
# Script to install and configure Catppuccin Mocha theme for SDDM
# Part of Zero-Drag Dotfiles

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================="
echo "Zero-Drag SDDM Theme Setup"
echo "Catppuccin Mocha Edition"
echo "========================================="
echo ""

# Check for sudo
if [ "$EUID" -ne 0 ]; then 
    echo -e "${YELLOW}Please run as root or with sudo equivalent permissions will be requested.${NC}"
fi

# 1. Install Dependencies
echo -e "${GREEN}Step 1: Installing dependencies...${NC}"

# Check for yay or use pacman
if command -v yay &> /dev/null; then
    PKG_MANAGER="yay"
else
    PKG_MANAGER="sudo pacman"
fi

DEPENDENCIES=(
    "qt5-graphicaleffects"
    "qt5-quickcontrols2"
    "qt5-svg"
)

$PKG_MANAGER -S --needed --noconfirm "${DEPENDENCIES[@]}"

# 2. Install the Theme
echo -e "${GREEN}Step 2: Installing Catppuccin Mocha theme...${NC}"

# Install unzip if not present
$PKG_MANAGER -S --needed --noconfirm unzip

# We use the release zip because the repo requires a build process (just + whiskers)
THEME_VERSION="v1.1.2"
THEME_FLAVOR="mocha"
THEME_ACCENT="mauve" # Default accent
THEME_NAME="catppuccin-${THEME_FLAVOR}-${THEME_ACCENT}"
ZIP_NAME="${THEME_NAME}-sddm.zip"
DOWNLOAD_URL="https://github.com/catppuccin/sddm/releases/download/${THEME_VERSION}/${ZIP_NAME}"

TEMP_DIR=$(mktemp -d)
DEST_DIR="/usr/share/sddm/themes"

echo "Downloading theme from $DOWNLOAD_URL..."
curl -L -o "$TEMP_DIR/$ZIP_NAME" "$DOWNLOAD_URL"

echo "Extracting theme..."
unzip -q "$TEMP_DIR/$ZIP_NAME" -d "$TEMP_DIR"

# The zip extracts to a folder named 'catppuccin-mocha-mauve' (without -sddm usually, or we check)
# Based on justfile: zip -r "../zips/${theme_name}-sddm" "${theme_name}"
# So it extracts to ${theme_name} which is catppuccin-mocha-mauve
EXTRACTED_DIR="$TEMP_DIR/$THEME_NAME"

if [ ! -d "$EXTRACTED_DIR" ]; then
    echo -e "${RED}Error: Extracted directory $EXTRACTED_DIR not found.${NC}"
    echo "Contents of temp dir:"
    ls -la "$TEMP_DIR"
    exit 1
fi

if [ -d "$DEST_DIR/$THEME_NAME" ]; then
    echo -e "${YELLOW}Theme directory already exists. Overwriting...${NC}"
    sudo rm -rf "$DEST_DIR/$THEME_NAME"
fi

echo "Moving theme to $DEST_DIR..."
sudo mv "$EXTRACTED_DIR" "$DEST_DIR/"

echo "Cleaning up..."
rm -rf "$TEMP_DIR"

# 3. Configure SDDM
echo -e "${GREEN}Step 3: Configuring SDDM...${NC}"

CONF_DIR="/etc/sddm.conf.d"
CONF_FILE="$CONF_DIR/theme.conf"

if [ ! -d "$CONF_DIR" ]; then
    echo "Creating $CONF_DIR..."
    sudo mkdir -p "$CONF_DIR"
fi

echo "Creating configuration file..."
echo "[Theme]
Current=$THEME_NAME" | sudo tee "$CONF_FILE" > /dev/null

# 4. Wallpaper Sync
echo -e "${GREEN}Step 4: Syncing wallpaper...${NC}"

# Define source and destination
WALLPAPER_SOURCE="$HOME/.config/hypr/wallpapers/digital_art.jpg"
# Fallback if specific file doesn't exist, try to find one in the wallpapers dir
if [ ! -f "$WALLPAPER_SOURCE" ]; then
    # Start looking in current dir since we might be running from the repo
    REPO_WALLPAPER="wallpapers/digital_art.jpg"
    if [ -f "$REPO_WALLPAPER" ]; then
         WALLPAPER_SOURCE="$(pwd)/$REPO_WALLPAPER"
    elif [ -f "$HOME/Zero_Drag.dotfiles/wallpapers/digital_art.jpg" ]; then
         WALLPAPER_SOURCE="$HOME/Zero_Drag.dotfiles/wallpapers/digital_art.jpg"
    fi
fi

THEME_BG_DIR="/usr/share/sddm/themes/$THEME_NAME/backgrounds"
THEME_BG_FILE="wall.jpg"
THEME_CONF="/usr/share/sddm/themes/$THEME_NAME/theme.conf"

if [ -f "$WALLPAPER_SOURCE" ]; then
    echo "Found wallpaper at: $WALLPAPER_SOURCE"
    
    # Ensure background dir exists (it should from the theme)
    sudo mkdir -p "$THEME_BG_DIR"
    
    echo "Copying wallpaper to theme directory..."
    sudo cp "$WALLPAPER_SOURCE" "$THEME_BG_DIR/$THEME_BG_FILE"
    
    echo "Updating theme configuration to use new wallpaper..."
    # Update the CustomBackground line if it exists, or add it
    # Use $THEME_CONF which is now correctly pointing to the new theme dir
    
    sudo sed -i 's|^Background=.*|Background=backgrounds/wall.jpg|' "$THEME_CONF"
    
    echo "Wallpaper configured."
else
    echo -e "${YELLOW}Warning: Wallpaper file not found at $WALLPAPER_SOURCE. Skipping wallpaper sync.${NC}"
fi

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}SDDM Setup Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo "To verify the new login screen, run:"
echo "sddm-greeter --test-mode --theme /usr/share/sddm/themes/$THEME_NAME"
echo ""
echo "Or simply reboot your system."
