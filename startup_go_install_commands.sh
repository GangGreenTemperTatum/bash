#!/bin/bash

# Output file for Go install commands
output_file="go_install_commands.sh"

# Get the GOPATH
gopath=$(go env GOPATH)

# Get a list of installed Go binaries in GOPATH/bin
installed_packages=$(ls "$gopath/bin")

# Start the output file with a shebang
echo "#!/bin/bash" > "$output_file"
echo "" >> "$output_file"

# Function to write a command to the output file
write_command() {
  echo "$1" >> "$output_file"
}

# Add install commands for each Go binary
echo "Generating Go install commands..."
for binary in $installed_packages; do
  # Find the full package import path using `go list`
  package_path=$(go list -f '{{.ImportPath}}' "$gopath/src/$binary" 2>/dev/null || echo "$binary")

  echo "Package: $package_path"
  write_command "go install $package_path@latest"
done

# Make the output file executable
chmod +x "$output_file"

echo "Go install commands have been written to $output_file."
