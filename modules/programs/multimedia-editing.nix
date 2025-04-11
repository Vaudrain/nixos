{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      blender
      openscad
      davinci-resolve
      gimp
      reaper
    ];
}