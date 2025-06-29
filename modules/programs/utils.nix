{ pkgs, user, ... }:

let
  pinnedRemmina = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "c2a03962b8e24e669fb37b7df10e7c79531ff1a4";
    sha256 = "1klhr7mrfhrzcqfzngk268jspikbivkxg96x2wncjv1ik3zb8i75";
  }) {
    inherit (pkgs) system;
  };
in
{
  home-manager.users.${user}.home.packages = with pkgs; [
pinnedRemmina.remmina
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