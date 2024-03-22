{ pkgs, user, ... }:
{
  home-manager.users.${user}.home.packages = with pkgs; [
      obs-studio
      obs-studio-plugins.obs-vkcapture
      virt-manager
      docker
      polychromatic
      xwayland
      jupyter
      #python3
      appimage-run

      #Communication
      discord
      zoom-us
      teams-for-linux
      slack

      #Other Apps
      kate
      vscode
      github-desktop
      mullvad-vpn
      neofetch
      obsidian
      vlc
      feh
      zotero
      libreoffice-qt
    ];
}
