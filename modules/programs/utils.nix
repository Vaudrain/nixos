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
      gnome.gnome-disk-utility
      psensor

      # Media utils
      vlc
      feh
      kate
      webcamoid
      gimp
    ];

  services = {
    flatpak = {
      packages = [
        "com.usebottles.bottles"
        "one.ablaze.floorp"
      ];
    };
  };
}