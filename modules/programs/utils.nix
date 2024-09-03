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
      mullvad-vpn
      fastfetch
      ventoy-full
      gnome-disk-utility
      psensor
      deluge
      baobab
      floorp

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
      ];
    };
  };
}