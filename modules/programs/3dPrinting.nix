{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [      
      bambu-studio
      orca-slicer
    ];

  services = {
    flatpak = {
      packages = [
        "io.mango3d.LycheeSlicer"
      ];
    };
  };
}