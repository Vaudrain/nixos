{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      steam
      gamemode
      vkbasalt
      mangohud
      gamescope
      protonup-qt
      obs-studio
      obs-studio-plugins.obs-vkcapture
    ];
}