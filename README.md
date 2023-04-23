# Building Custom Fedora Image
Steps for creating CentenV's custom Linux build based off of Fedora.

## Download and Install Fedora
https://fedoraproject.org/

---

## Installing/Configuring Applications
### Update the OS
```
sudo dnf update
```
### Installing GNOME (reboot when completed)
```
sudo dnf install @base-x gnome-shell gnome-terminal nautilus firefox gnome-browser-connector gnome-tweaks @development-tools
sudo systemctl set-default graphical.target
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
```
### Installing Extra Dependencies
```
sudo dnf group install "Hardware Support"
sudo dnf install git make vim nano
```

## OS Configuration
### Expanding the root partition
```
sudo lvextend -r -l +100%FREE /dev/mapper/fedora*
```
### Installing/Setting Up zsh (reboot when completed)
```
sudo dnf install zsh util-linux-user
chsh -s $(which zsh)
mkdir ~/.zsh
cp ~/.zshrc ~/.zshrc.bak
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
#### Zsh Extensions
```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" | tee -a ~/.zshrc
```
#### Zsh Theme
```
ZSH_THEME="jonathan"
```

## Miscellaneous
### Install GNOME Extensions
#### Install the GNOME browser extension
Chrome/Brave: https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep
#### Extensions:
- https://extensions.gnome.org/extension/3088/extension-list/
- https://extensions.gnome.org/extension/3193/blur-my-shell/
- https://extensions.gnome.org/extension/307/dash-to-dock/
- https://extensions.gnome.org/extension/1460/vitals/
### Gnome Configurations
#### Binding Ctrl + Alt + T to open terminal
`Settings` > `Keyboard` > `View and Customize Shortcuts` > `Custom Shortcuts` > `Add Shortcut`
#### Configuring the time display
`Settings` > `Date & Time` > **Time Format: AM/PM**
#### Enabling battery percentage
`Settings` > `Power` > **Show Battery Percentage=True**
#### Configuring Blur my Shell
`Extension List` > `Blur my Shell Settings` > **Sigma=10, Brightness=0.65,Color and noise effects=True, Panel blur=True, Static blur=True, Disable when a window is near=True, Background blue=True, Overview components style=Transparent, Application folder blur=True, Dash to Dock blur=False, Application blur=False, Lockscreen blur=True**
#### Configuring Dash to Dock
`Extension List` > `Dash to Dock Settings` > **Show on all monitors=True, Intelligent autohide=True, Show trashcan=False, Show overview on startup=False, Customize the dash color=True:black, Customize opacity=Fixed:75%**
#### Configuring Vitals
`Extension List` > `Vitals Settings` > **Position in panel=Center, Use higher precision=True**
`Vitals Extension` > Add **CPU: Usage, Frequency | Memory: Usage, Free | Storage: Free | Network: Public IP, Device rx**
### Install Brave
```
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser
```
### Install Neofetch
```
sudo dnf install neofetch
```
### Install Bashtop/Btop
```
sudo dnf install btop
```
### Install Virtualbox
```
sudo dnf install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
```
```
cat <<EOF | sudo tee /etc/yum.repos.d/virtualbox.repo 
[virtualbox]
name=Fedora \$releasever - \$basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/\$releasever/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox.asc
EOF 
```
```
sudo dnf install VirtualBox-7.0 
```