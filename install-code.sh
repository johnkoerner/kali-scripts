# Install this using the following command
# 
# . <(curl -s https://raw.githubusercontent.com/johnkoerner/kali-scripts/master/install-code.sh)
#

# Thanks to Rafe Hart for the majority of this script (https://www.rafaelhart.com/2017/08/install-visual-studio-code-on-kali-linux/)
# Download the Microsoft GPG key, and convert it from OpenPGP ASCII 
# armor format to GnuPG format
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg

# Move the file into your apt trusted keys directory (requires root)
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

# Add the VS Code Repository
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list

# Update and install Visual Studio Code 
apt update && apt install code

# create an alias for code, so it will run as root.
touch ~/.bash_aliases
echo "alias code=\"code --user-data-dir=\\\"~/.vscode-root\\\"\"" >> ~/.bash_aliases

# Reload the bash aliases so we can run it in this session
. ~/.bash_aliases

GREEN='\e[32m'
NC='\e[0m' # No Color

echo -e "Visual Studio Code is now setup. Type ${GREEN}code${NC} in a terminal to load it up."
code
