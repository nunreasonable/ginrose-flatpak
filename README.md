<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/ginrose-wordmark-light.png">
    <img alt="Ginrose" src="assets/ginrose-wordmark.png" width="320">
  </picture>
</p>

<p align="center">A Roblox launcher for Linux, built around <a href="https://github.com/microlift/rosemary">Rosemary</a>.</p>

> [!WARNING]
> ## This is a personal project
>
> Ginrose was made for one computer (Fedora, Hyprland, an NVIDIA card) and is
> only tested there. It may well not work on yours: other distros, desktops and
> GPUs have not been tried, and the installer has not been through many hands
> yet. It is shared as it is, with no promise of support or fixes. If it breaks
> for you, an issue is welcome, but it may not get an answer soon, or at all.
>
> Rosemary itself is experimental, and so is running Roblox on it.
> IF YOU USE THIS TO EXPLOIT I AM PERSONALLY GOING TO SEND 10 MISSILES TO YOUR HOME!!! TWAT!

This repository holds Ginrose's installer and its Flatpak releases. Ginrose's
source code is not public.

Ginrose runs the official macOS Roblox client on Linux through Rosemary, a
macOS compatibility layer. It downloads the client straight from Roblox, keeps
it up to date, sets it up to run well, and shows what you are playing on
Discord. The client itself is never modified.

## Install

You need [Flatpak](https://flatpak.org/setup/) and an x86_64 computer. Then:

```sh
curl -fsSL https://raw.githubusercontent.com/nunreasonable/ginrose-flatpak/main/install.sh | sh
```

The script downloads the latest release, checks it against `SHA256SUMS`,
installs the GNOME 51 runtime from Flathub and installs Ginrose for your user.
Nothing needs root. The setup downloads Roblox on the first run.

### By hand

Download `me.daeese.apps.ginrose.flatpak` and `SHA256SUMS` from the
[latest release](https://github.com/nunreasonable/ginrose-flatpak/releases/latest), then:

```sh
sha256sum -c --ignore-missing SHA256SUMS
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub org.gnome.Platform//51
flatpak install --user me.daeese.apps.ginrose.flatpak
```

To have it open the Play buttons on roblox.com when another app already does:

```sh
xdg-mime default me.daeese.apps.ginrose.player.desktop x-scheme-handler/roblox-player x-scheme-handler/roblox
```

### Update and uninstall

Run the install command again to update. To remove Ginrose:

```sh
flatpak uninstall --user me.daeese.apps.ginrose
```

Its data stays in `~/.var/app/me.daeese.apps.ginrose` until you delete that folder.

## Credits

- [Rosemary](https://github.com/microlift/rosemary) does the hard part:
  running macOS programs on Linux.
- [Nutmeg](https://github.com/frolleks/nutmeg) showed how a Rosemary
  bootstrapper fits together.
- The BloxstrapRPC message format comes from
  [Bloxstrap](https://github.com/bloxstraplabs/bloxstrap).

## License

Ginrose is proprietary software, free to download, use and redistribute
unmodified; see [LICENSE](LICENSE). The Flatpak includes Ginrose's build of
Rosemary, which is GPL-3.0; its source is at
[nunreasonable/rosemary](https://github.com/nunreasonable/rosemary/tree/mic-input).

Ginrose is not affiliated with or endorsed by Roblox Corporation.
