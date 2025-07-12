set -e

if [ -f /usr/sbin/pacman ]; then
    pacman -Syu --noconfirm
    pacman -Sy zsh npm --noconfirm
fi

if [ -f /etc/debian_version ]; then
    . /etc/os-release
    if [ "$ID" = "ubuntu" ] && [ "${VERSION_ID%%.*}" -ge 24 ]; then
        apt-get update
        apt-get install -y --fix-missing libgtk2.0-0t64 libgtk-3-0t64 libgbm-dev libnotify-dev libnss3 libxss1 libasound2t64 libxtst6 xauth xvfb
    else
        apt-get update
        apt-get install -y --fix-missing libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb
    fi
fi
