#!/bin/bash

# Define the directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Check if the directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Wallpaper directory not found: $WALLPAPER_DIR"
    exit 1
fi

# Show menu options in Rofi
option=$(printf "Select\nPreview\nCancel" | rofi -dmenu -i -p "Wallpaper Action")

case $option in
    "Select")
        # Use Rofi to select a wallpaper
        selected=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | rofi -dmenu -i -p "Select Wallpaper")
        ;;
    "Preview")
        # Launch Yazi to browse wallpapers
        kitty -e yazi ./Pictures/Wallpapers
        # Re-run the script after exiting Yazi
        exec "$0"
        ;;
    *)
        # Cancel or no selection
        exit 0
        ;;
esac

# Exit if no wallpaper is selected
if [ -z "$selected" ]; then
    echo "No wallpaper selected."
    exit 0
fi

# Apply the selected wallpaper using Pywal
wal -i "$selected"

# Set the wallpaper with swww
swww img "$selected"

# Optional: Notify the user
notify-send "Wallpaper Changed" "Applied $selected with Pywal."

