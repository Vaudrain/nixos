
{ pkgs, user, ... }:
{
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
