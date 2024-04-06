{ pkgs, ... }:
let
  sddmTheme = import ./sddm-theme.nix {inherit pkgs;};
in {
    environment.systemPackages = with pkgs; [ 
        libsForQt5.qt5.qtquickcontrols2   
        libsForQt5.qt5.qtgraphicaleffects 
    ];
    services.xserver = {
        enable = true;
        xkb = {
            layout = "gb";
            variant = "";
        };
        displayManager.sddm = {
            enable = true;
            wayland.enable = true;
            autoNumlock = true;
            #theme = "sugar-dark";
            enableHidpi = true;
        };
    };
}