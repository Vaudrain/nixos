{ pkgs, user, fetchFromGitHub, lib,  ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [      
      # vesktop
      discord
      zoom-us
      teams-for-linux 
      slack
    ];

  services = {
    flatpak = {
      packages = [
        "dev.vencord.Vesktop"
      ];
    };
  };
}