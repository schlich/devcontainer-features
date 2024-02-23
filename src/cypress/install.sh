set -e

if [ -f /usr/sbin/pacman ]; then
    pacman -Syu --noconfirm
    pacman -Sy zsh npm --noconfirm
fi

if [ -z /etc/debian_version ]; then
    apt-get update
    apt-get install -y --fix-missing libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb
fi
