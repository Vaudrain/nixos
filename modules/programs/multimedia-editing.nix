{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      blender
      openscad
      davinci-resolve
      shotcut
      gimp
      reaper
      aseprite
    ];
}