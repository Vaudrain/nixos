{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      docker
      polychromatic
      xwayland
      kdePackages.xwaylandvideobridge
      appimage-run
      kdePackages.plasma-browser-integration
      ncdu
      firefox
      fastfetch
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
      sunwait
      starship

      # Media utils
      vlc
      feh
      kdePackages.kate
      webcamoid
      mpg123
    ];

  services = {
    flatpak = {
      packages = [
      ];
    };
  };
}