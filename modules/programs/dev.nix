{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      github-desktop
      vscode
      nodejs_22
      godot_4
      python313
      python313Packages.pip
    ];
}