{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      blender
      freecad-wayland
      openscad
      davinci-resolve
      gimp
      reaper
      aseprite
    ];
}