#!/bin/bash

# Output file for pip install commands
output_file="pip_install_commands.sh"

# Get a list of installed pip packages (excluding system packages)
installed_packages=$(pip freeze)

# Start the output file with a shebang
echo "#!/bin/bash" > "$output_file"
echo "" >> "$output_file"

# Function to write a command to the output file
write_command() {
  echo "$1" >> "$output_file"
}

# Add install commands for each pip package
echo "Generating pip install commands..."
while IFS= read -r package; do
  echo "Package: $package"
  write_command "pip install $package"
done <<< "$installed_packages"

# Make the output file executable
chmod +x "$output_file"

echo "Pip install commands have been written to $output_file."
