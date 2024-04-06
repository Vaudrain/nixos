{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      obsidian
      zotero
      libreoffice-qt
    ];
}