{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      docker
      polychromatic
      xwayland
      xwaylandvideobridge
      appimage-run
      kdePackages.plasma-browser-integration
      ncdu
      firefox
      fastfetch
      ventoy-full
      gnome-disk-utility
      resources
      deluge
      baobab
      usbutils
      pciutils
      alsa-utils
      bottles
      killall
      glib
      dbus

      # Media utils
      vlc
      feh
      kate
      webcamoid
    ];

  services = {
    flatpak = {
      packages = [
      ];
    };
  };
}