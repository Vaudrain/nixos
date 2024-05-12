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

      # Media utils
      vlc
      feh
      kate
    ];
}