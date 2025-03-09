{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      steam
      gpu-screen-recorder-gtk
      gamemode
      vkbasalt
      mangohud
      gamescope
      protonup-qt
      obs-studio
      obs-studio-plugins.obs-vkcapture
      xivlauncher
      prismlauncher
      wowup-cf
    ];
}