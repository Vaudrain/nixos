{ pkgs, user, fetchFromGitHub, lib,  ... }:

let
  vesktop = pkgs.callPackage ./derivations/vesktop.nix { };
in
{
  home-manager.users.${user}.home.packages = with pkgs; [      
      vesktop
      zoom-us
      teams-for-linux
      slack
    ];
}