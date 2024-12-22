#!/bin/bash

handle_error() {
    echo "Error occurred in script at line: $1"
    exit 1
}

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

if ! command -v git &> /dev/null; then
    log_message "Git is not installed. Please install git first."
    exit 1
fi

LOG_FILE="$HOME/git_update_$(date '+%Y%m%d_%H%M%S').log"
touch "$LOG_FILE"

cd "$HOME/git" || handle_error $LINENO

find . -type d -name ".git" | while read -r gitdir; do
    repo_path=$(dirname "$gitdir")
    cd "$HOME/git/${repo_path}" || continue

    log_message "Processing repository: ${repo_path}" | tee -a "$LOG_FILE"

    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log_message "Warning: ${repo_path} is not a valid git repository, skipping..." | tee -a "$LOG_FILE"
        continue
    fi

    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@' 2>/dev/null)

    if [ -z "$default_branch" ]; then
        log_message "Warning: Could not determine default branch for ${repo_path}" | tee -a "$LOG_FILE"
        continue
    }

    log_message "Default branch is: ${default_branch}" | tee -a "$LOG_FILE"

    if ! git diff --quiet; then
        log_message "Warning: Uncommitted changes in ${repo_path}, skipping..." | tee -a "$LOG_FILE"
        continue
    fi

    if ! git fetch origin; then
        log_message "Error: Failed to fetch updates for ${repo_path}" | tee -a "$LOG_FILE"
        continue
    fi

    BEHIND=$(git rev-list HEAD..origin/${default_branch} --count 2>/dev/null)
    if [ "$BEHIND" -gt 0 ]; then
        log_message "Repository is behind by ${BEHIND} commits" | tee -a "$LOG_FILE"

        if git pull origin "${default_branch}"; then
            log_message "Successfully updated ${repo_path}" | tee -a "$LOG_FILE"
        else
            log_message "Warning: Failed to pull updates for ${repo_path}. There might be conflicts." | tee -a "$LOG_FILE"
        fi
    else
        log_message "Repository is up to date" | tee -a "$LOG_FILE"
    fi
done

log_message "Update process completed. Check ${LOG_FILE} for details."
