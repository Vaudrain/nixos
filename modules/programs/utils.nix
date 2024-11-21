{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      docker
      polychromatic
      xwayland
      xwaylandvideobridge
      appimage-run
      plasma-browser-integration
      ncdu
      floorp
      fastfetch
      ventoy-full
      gnome-disk-utility
      resources
      deluge
      baobab
      usbutils
      pciutils
      alsa-utils

      # Media utils
      vlc
      feh
      kate
      webcamoid
    ];

  services = {
    flatpak = {
      packages = [
        "com.usebottles.bottles"
        { appId = "one.ablaze.floorp"; origin = "flathub"; commit = "8521b33212e7e7cad2f3fd829db9c450556464aa5b94bba6a1abbd44103eba94"; } 
      ];
    };
  };
}