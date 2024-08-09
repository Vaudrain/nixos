{ pkgs, user, ... }:
{
  home-manager.users.${user}.home.packages = with pkgs; [
      # Temporary place for testing things before sorting.
    ];
}
