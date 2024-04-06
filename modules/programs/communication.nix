{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      vesktop
      zoom-us
      teams-for-linux
      slack
    ];
}