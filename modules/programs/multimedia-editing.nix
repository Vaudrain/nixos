{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      blender
      davinci-resolve
      gimp
    ];
}