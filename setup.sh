#!/bin/bash
# Script to install and setup my personal, custom version of Fedora

# Checking for updates
echo "-----UPDATING-----"
sudo dnf update -y

# Installing GNOME and support for GNOME extensions
echo "-----INSTALLING GNOME-----"
sudo dnf install @base-x gnome-shell gnome-terminal nautilus firefox gnome-browser-connector gnome-tweaks @development-tools -y
sudo systemctl set-default graphical.target
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# Installing extra packages/dependencies
echo "-----INSTALLING EXTRA DEPENDENCIES-----"
sudo dnf group install "Hardware Support" -y


# Expanding the partition
echo "-----EXPANDING ROOT PARTITION-----"
sudo lvextend -r -l +100%FREE /dev/mapper/fedora*


# Installing and changing default shell to zsh
echo "-----INSTALLING AND CHANGING DEFAULT SHELL TO ZSH AND CUSTOMIZING IT-----"
sudo dnf install zsh util-linux-user -y
chsh -s $(which zsh)

################ post installation not ready yet
mkdir ~/.zsh
cp ~/.zshrc ~/.zshrc.bak
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"     # Installing Oh My Zsh
# themes: jonathan, gnzh, agnoster
# gnome extensions: blur my shell, dash to dock, extension list, vitals

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions       # Auto-suggestion plugin
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" | tee -a ~/.zshrc


# Reboot
reboot