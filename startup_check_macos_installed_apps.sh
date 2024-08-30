#!/bin/bash

# Output file for the list of non-default macOS applications
output_file="macos_installed_apps.txt"

# Directories to check for installed applications
application_dirs=("/Applications" "$HOME/Applications")

# List of default macOS applications (you may need to expand this list)
default_apps=(
  "Activity Monitor.app"
  "App Store.app"
  "Automator.app"
  "Calculator.app"
  "Calendar.app"
  "Chess.app"
  "Contacts.app"
  "Dictionary.app"
  "FaceTime.app"
  "Find My.app"
  "Font Book.app"
  "GarageBand.app"
  "Home.app"
  "iMovie.app"
  "Keynote.app"
  "Launchpad.app"
  "Mail.app"
  "Maps.app"
  "Messages.app"
  "Music.app"
  "Notes.app"
  "Numbers.app"
  "Pages.app"
  "Photo Booth.app"
  "Photos.app"
  "Preview.app"
  "QuickTime Player.app"
  "Reminders.app"
  "Safari.app"
  "Siri.app"
  "Stickies.app"
  "System Preferences.app"
  "TextEdit.app"
  "Time Machine.app"
  "TV.app"
  "Voice Memos.app"
)

# Start the output file with a header
echo "List of non-default macOS applications installed on this system:" > "$output_file"
echo "" >> "$output_file"

# Function to check if an app is a default app
is_default_app() {
  for default_app in "${default_apps[@]}"; do
    if [[ "$1" == "$default_app" ]]; then
      return 0
    fi
  done
  return 1
}

# Find and list non-default applications
echo "Generating list of non-default macOS applications..."
for dir in "${application_dirs[@]}"; do
  if [[ -d "$dir" ]]; then
    for app in "$dir"/*.app; do
      app_name=$(basename "$app")
      if ! is_default_app "$app_name"; then
        echo "Found non-default app: $app_name"
        echo "$app_name" >> "$output_file"
      fi
    done
  fi
done

echo "List of non-default macOS applications has been written to $output_file."
