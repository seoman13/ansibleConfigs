#!/bin/zsh

echo "==========================================="
echo "Setting up Mac"
echo "==========================================="

##################################################################
###  Dock, Finder
##################################################################

# Show dock apps process indicator
defaults write com.apple.dock show-process-indicators -bool true

# Show recent apps in dock 
defaults write com.apple.dock show-recents -bool true

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array

# Set location
defaults write com.apple.dock orientation -string "bottom"

# Automatically hide and show the Dock
# defaults write com.apple.dock autohide -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# When performing a search, search the current folder by default
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use columns view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `Nlsv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show the ~/Library folder
chflags nohidden ~/Library

# Remove Dock show delay
# defaults write com.apple.dock autohide-delay -float 0

# Remove Dock show delay
# defaults write com.apple.dock autohide-time-modifier -float 0

# Disable Bouncing dock icons:
# defaults write com.apple.dock no-bouncing -bool True

##################################################################
###  Safari
##################################################################

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

##################################################################
###  Xcode
##################################################################

# Trim trailing whitespace
defaults write com.apple.dt.Xcode DVTTextEditorTrimTrailingWhitespace -bool true

# Trim whitespace only lines
defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines -bool true

# Show line numbers
defaults write com.apple.dt.Xcode DVTTextShowLineNumbers -bool true

# Show ruler at 80 chars
defaults write com.apple.dt.Xcode DVTTextShowPageGuide -bool true
defaults write com.apple.dt.Xcode DVTTextPageGuideLocation -int 80

# Disable automatic updates
defaults write com.apple.dt.Xcode DVTDownloadableAutomaticUpdate -bool false

##################################################################
###  Login
##################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Don't show any password hints
sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0

# Disable guest user
defaults write com.apple.AppleFileServer guestAccess -bool false
defaults write SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool false

##################################################################
###  Trackpad, Keyboard
##################################################################

# Trackpad: disable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0

# Maximize trackpad speed (higher -> faster)
defaults write -g com.apple.trackpad.scaling 3

# App Exposé
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Delay Until Repeat
defaults write NSGlobalDomain "InitialKeyRepeat_Level_Saved" -int 0

# Set maximum keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Maximize Delay Until Repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Make holding down a key repeat characters
defaults write -g ApplePressAndHoldEnabled -bool true

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true

# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

##################################################################
###  Mac
##################################################################

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "seoman"
sudo scutil --set HostName "seoman"
sudo scutil --set LocalHostName "seoman"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "seoman"

# Turn Bluetooth off.
sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0  

# Set Locale
defaults write NSGlobalDomain AppleLanguages -array "en" "ru"
defaults write NSGlobalDomain AppleLocale -string "en_RU"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# 24 hour time
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
# defaults write NSGlobalDomain AppleICUTimeFormatStrings -dict \
#   1 -string "H:mm" \
#   2 -string "H:mm:ss" \
#   3 -string "H:mm:ss z" \
#   4 -string "H:mm:ss zzzz"

#Download updates automatically in the background
defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool YES

# Install app updates automatically (NO)
defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool NO

# Don't Install macos updates automatically
defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool false

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
# defaults write com.apple.finder FXInfoPanesExpanded -dict \
# 	General -bool true \
# 	OpenWith -bool true \
# 	Privileges -bool true

# Disable Dashboard (by default)
defaults write com.apple.dashboard mcx-disabled -boolean YES

# Install Xcode Command Line Tools
# https://github.com/timsutton/osx-vm-templates/blob/ce8df8a7468faa7c5312444ece1b977c1b2f77a4/scripts/xcode-cli-tools.sh
# touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
# PROD=$(softwareupdate -l |
#   grep "\*.*Command Line" |
#   head -n 1 | awk -F"*" '{print $2}' |
#   sed -e 's/^ *//' |
#   tr -d '\n')
# softwareupdate -i "$PROD" -v;

# to track all implicitly called defaults write command, add the following to .zshprofile
# PROMPT_COMMAND='echo "$(history 1 | grep "defaults write")" | sed '/^$/d' >> ~/Documents/defaults-write.txt'


echo "Installing Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Installing pip"
sudo easy_install pip

echo "Installing Ansible"
sudo pip install ansible

installdir="/tmp/setupmac-$RANDOM"
mkdir $installdir

git clone https://github.com/seoman13/ansibleConfigs.git $installdir
if [ ! -d $installdir ]; then
    echo "Failed to clone repo"
    exit 1
else
    cd $installdir
    echo "Running ansible-playbook"
    ansible-playbook -i ./hosts playbook.yml --verbose
fi

echo "Wrapping up..."
rm -Rfv /tmp/$installdir

exit 0
