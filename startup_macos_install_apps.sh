#!/bin/bash

# Directory to store downloaded applications
install_dir="$HOME/Downloads/installme"
failed_log="$HOME/Downloads/failedinstalls.log"

# Create the install directory and log file if they don't exist
mkdir -p "$install_dir"
touch "$failed_log"

# List of application names and their download URLs
apps=(
  "Amazon Kindle|https://www.amazon.com/kindle-dbs/fd/kcp"
  "Anaconda Navigator|https://www.anaconda.com/products/distribution#download-section"
  "AnyList|https://apps.apple.com/us/app/anylist-grocery-shopping-list/id522167641?mt=12"
  "Arc|https://arc.net/download"
  "Bartender 5|https://www.macbartender.com"
  "Brave Browser|https://laptop-updates.brave.com/latest/osx"
  "Burp Suite Professional|https://portswigger.net/burp/releases/professional-community"
  "Caido|https://caido.io"
  "Chromium|https://download-chromium.appspot.com"
  "Cursor|https://www.cursorapp.com"
  "DevUtils|https://devutils.app"
  "Discord|https://discord.com/api/download?platform=osx"
  "DuckDuckGo|https://duckduckgo.com/app/mac"
  "Evernote|https://evernote.com/download"
  "FileZilla|https://filezilla-project.org/download.php?platform=osx"
  "Firefox|https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=en-US"
  "Gifski|https://github.com/sindresorhus/Gifski/releases/latest/download/Gifski.dmg"
  "GraphiQL|https://github.com/graphql/graphiql/releases/latest/download/GraphiQL.dmg"
  "Hidden Bar|https://github.com/dwarvesf/hidden/releases/latest/download/Hidden.dmg"
  "Kindle|https://www.amazon.com/kindle-dbs/fd/kcp"
  "Linear|https://linear.app/download"
  "Loom|https://www.loom.com/desktop"
  "Multipass|https://multipass.run"
  "Notion|https://www.notion.so/desktop"
  "Obsidian|https://obsidian.md/download"
  "Ollama|https://ollama.com"
  "OpenVPN Connect|https://openvpn.net/client-connect-vpn-for-mac-os/"
  "Postman|https://www.postman.com/downloads"
  "PowerShell|https://github.com/PowerShell/PowerShell/releases/latest/download/PowerShell-7.3.4-osx-x64.pkg"
  "Raycast|https://www.raycast.com"
  "Rocket|https://matthewpalmer.net/rocket/"
  "Signal|https://signal.org/download/"
  "Slack|https://slack.com/downloads/mac"
  "Spotify|https://www.spotify.com/download/mac"
  "Sublime Text|https://download.sublimetext.com/Sublime%20Text%20Build%204213.dmg"
  "Tailscale|https://tailscale.com/download"
  "Threema|https://threema.ch/en/download"
  "Tor Browser|https://www.torproject.org/download/"
  "TunnelBear|https://www.tunnelbear.com/download"
  "Tuple|https://tuple.app/download"
  "UTM|https://mac.getutm.app/download"
  "VMware Fusion|https://www.vmware.com/go/getfusion"
  "Visual Studio Code|https://code.visualstudio.com/Download"
  "Warp|https://www.warp.dev/download"
  "Wave|https://waveform.com/download"
  "WhatsApp|https://www.whatsapp.com/download"
  "WireGuard|https://www.wireguard.com/install/"
  "Wireshark|https://www.wireshark.org/download.html"
  "ZAP|https://www.zaproxy.org/download/"
  "Zenmap|https://nmap.org/download.html"
  "iTerm|https://iterm2.com/downloads.html"
)

# Function to download applications
download_app() {
  app_name="$1"
  url="$2"
  output_file="$install_dir/${app_name// /_}.dmg"  # Replace spaces with underscores

  # Print the download attempt
  echo "Attempting to download $app_name from $url..."

  # Download the app using curl. '-L' follows redirects.
  if ! curl -L -o "$output_file" "$url"; then
    echo "Failed to download $app_name from $url" | tee -a "$failed_log"
  else
    echo "Successfully downloaded $app_name to $output_file."
  fi
}

# Iterate over each application and download it
for app in "${apps[@]}"; do
  IFS="|" read -r app_name url <<< "$app"
  download_app "$app_name" "$url"
done

echo "Download process complete. Check $failed_log for any errors."
