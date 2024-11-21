{ pkgs, user, fetchFromGitHub, lib,  ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [      
      vesktop
      zoom-us
      teams
      slack
    ];
}