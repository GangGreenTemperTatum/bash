#!/bin/bash

# Define color schemes
BOLD_WHITE='\033[1;37m'
GREEN='\033[0;32m'
BOLD_RED='\033[1;31m'
RESET='\033[0m' # No Color

# Define variables from environment variables
GITHUB_USERNAME="${GITHUB_USERNAME:-your_github_username}"
OUTPUT_DIR="${GITHUB_OUTPUT_DIR:-$HOME/git}"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Function to check if a command is installed
function check_command_installed {
  if ! command -v "$1" &>/dev/null; then
    echo -e "${BOLD_RED}Error: $1 is not installed.${RESET}" >&2
    exit 1
  fi
}

# Function to fetch repositories using gh
function fetch_repositories {
  REPOS=$(gh repo list --json name,sshUrl --limit 100 | jq -r '.[] | "\(.name) \(.sshUrl)"')

  if [ -z "$REPOS" ]; then
    echo -e "${BOLD_RED}No repositories found or error fetching repositories.${RESET}"
    exit 1
  fi

  echo "$REPOS"
}

# Function to clone repositories
function clone_repositories {
  local repos="$1"

  while read -r REPO; do
    REPO_NAME=$(echo "$REPO" | awk '{print $1}')
    REPO_URL=$(echo "$REPO" | awk '{print $2}')

    echo -e "${BOLD_WHITE}Cloning $REPO_NAME...${RESET}"

    if git clone "$REPO_URL" "$OUTPUT_DIR/$REPO_NAME"; then
      echo -e "${GREEN}Successfully cloned $REPO_NAME${RESET}"
    else
      echo -e "${BOLD_RED}Failed to clone $REPO_NAME${RESET}" >&2
    fi
  done <<< "$repos"
}

# Main execution
check_command_installed gh
check_command_installed git
check_command_installed jq

REPOS=$(fetch_repositories)
clone_repositories "$REPOS"

echo -e "${GREEN}All repositories cloned into $OUTPUT_DIR.${RESET}"
