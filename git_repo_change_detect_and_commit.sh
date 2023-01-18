#!/usr/bin/env sh
# ^^^^^^^^^^^^^^^ This says find the first instance of a sh (shell)
# binary and use that shell to execute these commands.
# There is little to no complexity here and no bashisms so it
# should work just fine on most systems and instances of shells
# (bash, zsh, sh, etc.)

GIT_PATH="~/Documents/ObsidianMD"
# ^^^^^^^^^^^^^^^^^^^^^^^^^^ We are assigning the variable `GIT_PATH`
# with the (maybe) long string to our vault's location (mine is super
# long so this makes the final command look cleaner,
# it's unnecessary if you care)

cd "$ZK_PATH"
# ^^^^^^^^^^^ cd: Change Directory to your vault's location

git pull
# ^^^^^^ So if any changes occurred remotely or on another machine
# your local machine knows to pull those changes down instead of
# having to wait for a local change to run the script

CHANGES_EXIST="$(git status --porcelain | wc -l)"
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ we are assigning
# a value to the variable `CHANGES_EXIST`, the value is the output
# of `git add --porcelain` which outputs a simple list of just the
# changed files and then the output is piped into the `wc` utility
# which is "word count" but with the `-l` flag it will count lines.
# basically, it says how many total files have been modified.
# if there are no changes the output is 0

if [ "$CHANGES_EXIST" -eq 0 ]; then
	exit 0
fi
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The whole if block is saying
# in plain english: if there are no changes (CHANGES_EXIST = 0)
# then exit with no error code `exit 0` if there are changes,
# then continue on with the script

git pull
# ^^^^^^ git pull: this will look at your repo and say "any changes?"
# if there are they will be brought down and applied to your local machine
# In the context of a team environment, a more robust approach is needed
# as this workflow doesnt factor in branches, merge conflicts, etc
# but if you leave your home machine, do work on the work machine,
# push to the remote repo before you return to the home machine, then
# you can just get the latest changes applied to the home machine and
# continue on like normal
git add .
# ^^^^^^^ git add. = add all current changes in the repo no
# matter the level of nested folders/files
git commit -q -m "Last Sync: $(date +"%Y-%m-%d %H:%M:%S")"
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# git commit -q -m: this says we are committing changes to
# our repo, -q says BE QUIET no output prints to terminal
# if ran manually, -m defines a message for the commit log
# the -m message is "Last Sync: $(date +"%Y-%m-%d %H:%M:%S")" this
# runs the command date with the formatting arguments for a
# date in YYYY-MM-DD HH-MM-SS format as your commit message
git push -q
# ^^^^^^^^^ git push -q: push the changes to github and
# BE QUIET about it The semicolons between commands are
# just saying run each command and then run the subsequent
# command, they're just separators
