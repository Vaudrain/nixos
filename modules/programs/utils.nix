{ pkgs, user, ... }:

let
  remmina_with_old_ffmpeg = pkgs.remmina.override {
    freerdp = pkgs.freerdp.override {
      ffmpeg = pkgs.ffmpeg_7-full;
    };
  };
  librewolf_with_integration = pkgs.librewolf.override {
    cfg = {
      nativeMessagingHosts = {
        packages = [
          pkgs.kdePackages.plasma-browser-integration
        ];
      };
    };
  };
in
{
  programs.firefox.enable = true;
  programs.firefox.package = pkgs.firefox.override {
    cfg.nativeMessagingHosts.packages = [
      pkgs.kdePackages.plasma-browser-integration
    ];
  };
  home-manager.users.${user}.home.packages = with pkgs; [
      remmina_with_old_ffmpeg
      docker
      polychromatic
      xwayland
      appimage-run
      kdePackages.koi
      kdePackages.yakuake
      ncdu
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
      rustdesk
      librewolf_with_integration

      # Media utils
      vlc
      feh
      kdePackages.kate
      webcamoid
      mpg123
      vulkan-hdr-layer-kwin6

      # Fonts
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono

      # Security
      bitwarden-desktop
      veracrypt
    ];

  services = {
    flatpak = {
      packages = [
      ];
    };
  };
}