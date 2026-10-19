#!/bin/sh
# Install Ginrose's Flatpak for the current user.
#
#   curl -fsSL https://raw.githubusercontent.com/nunreasonable/ginrose-flatpak/main/install.sh | sh
#
# Downloads the latest release's bundle, checks it against SHA256SUMS, installs
# the GNOME runtime it needs from Flathub, then installs Ginrose itself.
# Everything goes into your user's Flatpak installation; nothing needs root.
set -eu

REPO="nunreasonable/ginrose-flatpak"
APP="me.daeese.apps.ginrose"
BUNDLE="$APP.flatpak"
RUNTIME="org.gnome.Platform//51"
BASE="https://github.com/$REPO/releases/latest/download"

say() { printf '\033[1;35m::\033[0m %s\n' "$*"; }
die() { printf '\033[1;31m!!\033[0m %s\n' "$*" >&2; exit 1; }

[ "$(uname -s)" = Linux ] || die "Ginrose runs on Linux."
[ "$(uname -m)" = x86_64 ] || die "Ginrose is built for x86_64 for now."
command -v flatpak >/dev/null || die "Install Flatpak first: https://flatpak.org/setup/"
command -v curl >/dev/null || die "curl is needed to download Ginrose."
command -v sha256sum >/dev/null || die "sha256sum is needed to check the download."

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT INT TERM

say "Downloading Ginrose"
curl -fL --progress-bar -o "$tmp/$BUNDLE" "$BASE/$BUNDLE" \
    || die "Could not download $BUNDLE."
curl -fsSL -o "$tmp/SHA256SUMS" "$BASE/SHA256SUMS" \
    || die "Could not download SHA256SUMS."
(cd "$tmp" && grep " $BUNDLE\$" SHA256SUMS | sha256sum -c --quiet -) \
    || die "The download does not match SHA256SUMS; not installing it."

say "Adding Flathub for the runtime"
flatpak remote-add --user --if-not-exists flathub \
    https://dl.flathub.org/repo/flathub.flatpakrepo

say "Installing $RUNTIME"
flatpak install --user -y --noninteractive flathub "$RUNTIME"

say "Installing Ginrose"
flatpak install --user -y --noninteractive --reinstall "$tmp/$BUNDLE"

# Play buttons on roblox.com open roblox-player:// and roblox:// links.
if command -v xdg-mime >/dev/null; then
    xdg-mime default "$APP.player.desktop" \
        x-scheme-handler/roblox x-scheme-handler/roblox-player || true
fi

say "Done. Open Ginrose from your app menu, or run: flatpak run $APP"
