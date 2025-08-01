{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      remmina
      docker
      polychromatic
      xwayland
      kdePackages.xwaylandvideobridge
      appimage-run
      kdePackages.plasma-browser-integration
      kdePackages.koi
      kdePackages.yakuake
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
      pulseaudio

      # Media utils
      vlc
      feh
      kdePackages.kate
      webcamoid
      mpg123

      # Fonts
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
    ];

  services = {
    flatpak = {
      packages = [
      ];
    };
  };
}