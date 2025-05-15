{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      github-desktop
      #vscode
      vscode-fhs
      nodejs_22
      godot
      python313
      python313Packages.pip
      dotnet-sdk
    ];
}