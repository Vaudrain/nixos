{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      docker
      polychromatic
      xwayland
      appimage-run
      plasma-browser-integration
      ncdu
      mullvad-vpn
      neofetch
      ventoy-full
      gnome.gnome-disk-utility
      psensor
      linux-wallpaperengine-unstable

      # Media utils
      vlc
      feh
      kate
    ];
}