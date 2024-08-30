#!/bin/bash

# Output file for brew install commands
output_file="brew_install_commands.sh"

# Get a list of installed formulas
installed_formulas=$(brew list --formula)

# Get a list of installed casks
installed_casks=$(brew list --cask)

# Start the output file with a shebang
echo "#!/bin/bash" > "$output_file"
echo "" >> "$output_file"

# Function to write a command to the output file
write_command() {
  echo "$1" >> "$output_file"
}

# Add install commands for each formula
echo "Generating Homebrew formula install commands..."
for formula in $installed_formulas; do
  echo "Formula: $formula"
  write_command "brew install $formula"
done

# Add install commands for each cask
echo "Generating Homebrew cask install commands..."
for cask in $installed_casks; do
  echo "Cask: $cask"
  write_command "brew install --cask $cask"
done

# Make the output file executable
chmod +x "$output_file"

echo "Brew install commands have been written to $output_file."
