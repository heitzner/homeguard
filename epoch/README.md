# Epoch 

> I now use KDE Plasma, but I will keep the i3 configuration files as part of the archive.

## Legend:
<details>
 <summary>List</summary>
 
- [R] - **Required**

- [o] - **Optional**

- [nR] - **Not Required/Needed**

- [E] - **Essential**

- [re] - **Recommended**

- [x11] - **X11 Program, unlikely to run on Wayland**

- [w] - **Wayland Program, mostly native**

- [w2x] - **Program can run on either X11 or Wayland**

- [G] - **Can be installed from the Gentoo Repository**

- [gr] - **Package is outside of Gentoo Repository, lives in GURU**

- [RC] - **OpenRC Specific**

- [SYSD] - **Systemd Specific**

- [F] - **Flatpak Program**

- [K] - **KDE**

</details>

### A combination of this would look like:

```
sys-devel/gcc [RreE]
```

<details>
 <summary>Package list, and their combinations</summary>

|          |               |
| --------------- | ------------- | 
|app-admin/eclean-kernel|  [reG]
|app-admin/sudo| [oG]
|app-admin/sysklogd| [reRCG]
|app-editors/emacs| [oG]
|app-editors/featherpad| [ow2xG]
|app-editors/neovim| [ow2xG]
|app-editors/vim| [ow2xG]
|app-editors/vscode| [Ew2xG]
|app-eselect/eselect-repository| [EG]
|app-misc/fastfetch| [oG]
|app-misc/keyd| [nRwgr]
|app-misc/tmux| [ow2xG]
|app-misc/zellij| [ow2xG]
|app-office/onlyoffice-bin| [rew2xG]
|app-portage/genlop| [reEG]
|app-portage/gentoolkit| [reEG]
|app-portage/smart-live-rebuild| [oG]
|app-shells/bash-completion| [oreG]
|app-shells/fzf| [reG]
|app-shells/starship| [oG]
|app-text/marknote| [nrF]
|app-text/tree| [oG]
|dev-qt/qttools| [oG]
|dev-util/github-cli| [oreG]
|dev-vcs/git| [RG]
|gui-apps/foot| [owG]
|gui-apps/wl-clipboard| [owG]
|kde-apps/dolphin| [Kw2xG]
|kde-apps/filelight| [Kw2xG]
|kde-plasma/plasma-meta| [Kw2xG]
|kde-plasma/plasma-pa| [Kw2xG]
|media-fonts/corefonts| [oreG]
|media-fonts/noto| [oreG]
|media-gfx/flameshot| [oGw2x]
|media-gfx/nomacs| [oGw2x]
|media-libs/libva-intel-driver| [oG]
|media-libs/svt-av1| [oG]
|media-libs/woff2| [oG]
|media-plugins/gst-plugins-opus| [oG]
|media-plugins/obs-pipewire-audio-capture| [oG]
|media-video/ffmpegthumbnailer| [reG]
|media-video/mpv| [reG]
|media-video/obs-studio| [reG]
|net-im/discord| [oG]
|net-libs/nodejs| [oG]
|net-misc/networkmanager| [oG]
|sys-apps/bat| [nRG]
|sys-apps/dmidecode| [oG]
|sys-apps/eza| [nRG]
|sys-apps/flatpak| [oG]
|sys-apps/mlocate| [oG]
|sys-apps/xdg-dbus-proxy| [EG]
|sys-auth/rtkit| [EG]
|sys-auth/seatd| [RCEG]
|sys-boot/grub| [EG]
|sys-fs/duf| [oG]
|sys-fs/fuse:0| [oG]
|sys-kernel/gentoo-kernel-bin| [EG]
|sys-kernel/installkernel| [EG]
|sys-kernel/linux-firmware| [EG]
|sys-kernel/modprobed-db| [oG]
|sys-kernel/ugrd| [EreG]
|sys-libs/ncurses| [EG]
|sys-power/throttled| [oG]
|sys-process/btop| [oG]
|sys-process/cronie| [oRCG]
|sys-process/nvtop| [oG]
|www-client/google-chrome| [oG]
|x11-drivers/nvidia-drivers| [oG]
|gui-apps/packettracer| [oG]

</details>

# Archived Section

### Optional - Packet Tracer (trying from KDE Plasma >=6.8.7, this works now out of the box without anything needed)

I would be about 99.5% sure that no one would even use this, in Gentoo. But apparently I do. Thanks to this [reddit thread](https://www.reddit.com/r/Gentoo/comments/1qk403f/how_to_get_packet_tracer_822_working_on_gentoo/).

### Requirements:
- [GURU](https://wiki.gentoo.org/wiki/Project:GURU)

Grab the archive:

```
wget https://archive.org/download/cpt822/CiscoPacketTracer822_amd64_signed.deb
```

Move onto `distfiles`:

```
sudo mv CiscoPacketTracer822_amd64_signed.deb /var/cache/distfiles/Packet_Tracer822_amd64_signed.deb
```

Accept keyword in `package.accept_keywords`:

```
echo "gui-apps/packettracer ~amd64" | sudo tee -a /etc/portage/package.accept_keywords/packettracer
```

Accept license in `package.license`:

```
echo "gui-apps/packettracer Cisco" | sudo tee /etc/portage/package.license/packettracer
```

Install:

```
sudo emerge -aq gui-apps/packettracer dev-qt/qtnetworkauth dev-libs/libxml2-compat
```

Ensure that libraries will work before launching:

```
export LD_LIBRARY_PATH="/opt/pt/bin:/usr/lib:${LD_LIBRARY_PATH}"
```

Link the program onto `/usr/local/bin`:

```
sudo ln -s /opt/pt/packettracer /usr/local/bin/
```

Upon login, click "Skills for All", for some reason I cannot login with the "Networking Academy" option
