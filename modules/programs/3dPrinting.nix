{ pkgs, user, ... }:

{
  home-manager.users.${user}.home.packages = with pkgs; [
      orca-slicer
    ];

  services = {
    flatpak = {
      packages = [
        "io.mango3d.LycheeSlicer"
        "com.bambulab.BambuStudio"
        "org.freecad.FreeCAD"
      ];
    };
  };
}