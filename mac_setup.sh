#!/bin/bash
echo "Setting up new mac... Hopefully..."
#echo "[x] Setting up sudo"
#sudo awk '/%admin/ {print; print  "\nfred\tALL=(ALL) NOPASSWD: ALL"; next}1' /etc/sudoers >/tmp/sudoers
#sudo chown root:wheel /tmp/sudoers
#sudo chmod 440 /tmp/sudoers
#sudo mv /tmp/sudoers /etc/sudoers

echo "[x] Setting up requirements"
echo "[x] Installing xcode."
xcode-select --install
sudo xcodebuild -license
echo -n "Press enter once Xcode is installed... "
read x

echo "[x] Setting up zsh / environment"
cd ~
git clone https://github.com/azafred/MasterRepo.git
echo "[x] Fixing ssh git"
sed -i 's/https:\/\/github.com\/azafred/git@github.com:azafred/' ~/MasterRepo/.git/config
cd ~/MasterRepo
./init.sh
sudo chsh -s /bin/zsh $USER

echo "[x] Installing Homebrew."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
echo "Press enter after making sure that brew doctor is ok..."
read x
brew update
brew upgrade

echo "[x] Installing Cask for homebrew."
brew tap 'phinze/cask'
brew tap 'gapple/services'
brew tap 'caskroom/versions'
brew tap 'Caskroom/cask/atom'
brew install brew-cask

echo "[x] Installing brew packages."
#brews=(zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-navigation-tools zsh-syntax-highlighting ripgrep python blackbox atom arcanist jq gpg-agent ack autoconf automake autossh boxes brew-cask cmake coreutils cscope dnsmasq easy-git ec2-ami-tools ec2-api-tools figlet fish fontconfig fontforge freetype gd gdbm gettext git git-extras git-flow git-ssh glib htop-osx icu4c iftop jpeg keychain libevent libffi libgpg-error libksba libpng libssh2 libtiff libtool libxml2 libxslt libyaml macvim midnight-commander mobile-shell monit mtr mysql nmap openssl pcre pkg-config protobuf readline ruby s-lang sqlite sshuttle task tmux tree unrar vnstat wget xz zsh zsh-completions zsh-lovers awscli keybase gnupg)
brews=$(cat ~/MasterRepo/packages/brew.list | tr '\n' ' ')
for b in ${brews[@]}; do
        echo "========== Installing $b ==========";
        brew install $b >>~/install.log 2>&1 && echo "[==] Installed $b sucessfully." || echo "[!!] Install of $b failed."; echo "brew $b failed" >> ~/install.failed.log;
done

echo "[x] Installing Chrome, Alfred, Sublime-text, Adium, Vypervpn, hipchat, path-finder, iterm2, macvim, spotify, cord, dropbox, evernote, filebot, firefox, plex-home-theater, hyperdock, vmware-fusion, wireshark"
#casks=(1password slack-beta shimo plex-media-player microsoft-office adobe-acrobat caskroom/cask/adobe-creative-cloud qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql webpquicklook suspicious-package cheatsheet totalfinder transmission 'flux' 'github' 'sublime-text3' 'google-chrome' 'firefox' 'alfred' 'adium' 'vyprvpn' 'hipchat' 'perian' 'transmit' 'path-finder' 'iterm2' 'macvim' 'spotify' 'cord' 'dropbox' 'evernote' 'filebot' 'firefox' 'plex-home-theater' 'hyperdock' 'vmware-fusion' 'wireshark' 'screenflow' 'adobe-creative-cloud' 'adobe-photoshop-lightroom' 'boot2docker' 'pushbullet' 'gpgtools' )
casks=$(cat ~/MasterRepo/packages/brew_cask.list | tr '\n' ' ')
for c in ${casks[@]}; do
        echo "========== Installing $c ==========";
        brew cask install --appdir=/Applications $c >>~/install.log 2>&1 && echo "[==] Installed $c sucessfully." || echo "[!!] Install of $c failed."; echo "cask $b failed" >> ~/install.failed.log;
done

# echo "[x] Installing RVM"
# curl -sSL https://get.rvm.io | bash -s stable --ruby
# rvm install ruby-1.9.3-p551
# rvm install ruby-2.2.0
# rvm install ruby-2.2.1

echo "Download the private GPG key in ~/key... then press RETURN"
read x
gpg --import ~/key
rm -rf ~/key

cd ~/MasterRepo
./init.sh

echo "[x] Setup Repos"
mkdir -p ~/Repos/forks
cd ~/Repos
for urls in $(cat ~/MasterRepo/packages/repo_list); do
    echo "[-] Cloning $urls"
    git clone $urls >>~/install.log 2>&1 && echo "[==] Cloned $url sucessfully." || echo "[!!] Clone of $url failed."; echo "clone of $b failed" >> ~/install.failed.log
done

echo "[x] Setup pip (global)"
for pips in $(cat ~/MasterRepo/packages/pip_packages); do
    echo "[-] Installing ${pips}"
    sudo -H pip install --ignore-installed ${pips} >>~/install.log 2>&1 && echo "[==] Installed $pips sucessfully." || echo "[!!] Install of $pips failed."; echo "pip install  $b failed" >> ~/install.failed.log
done


echo "[x] Setting up mac preferences"
# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "
# Set highlight color to green
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"
# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on
# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Disable local Time Machine snapshots
sudo tmutil disablelocal
# Disable hibernation (speeds up entering sleep mode)
sudo pmset -a hibernatemode 0
# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true
# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0
# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"
# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true
# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true
# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0
# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true
# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
# Enable the MacBook Air SuperDrive on any Mac
sudo nvram boot-args="mbasd=1"
# Show the ~/Library folder
chflags nohidden ~/Library
defaults write com.apple.finder FXInfoPanesExpanded -dict \
        General -bool true \
        OpenWith -bool true \
        Privileges -bool true
# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true
# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36
# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true
# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true
# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
# Display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false
# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5
# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0
# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
# Disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
# Allow installing user scripts via GitHub Gist or Userscripts.org
defaults write com.google.Chrome ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"
defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://gist.githubusercontent.com/" "http://userscripts.org/*"
# Use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true
# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true
defaults write com.apple.finder AppleShowAllFiles YES
echo "Setup Completed."
echo "The following things failed:"
cat ~/install.failed.log
echo "Look at the ~/install.log for more info"
