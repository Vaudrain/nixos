{ pkgs, ... }:
let
  sddm-theme = (pkgs.callPackage ./sugar-dark/default.nix {});
in {
    environment.systemPackages = with pkgs; [ 
        pkgs.xorg.xrandr
        libsForQt5.qt5.qtquickcontrols2   
        libsForQt5.qt5.qtgraphicaleffects 
        libsForQt5.qt5.qtbase 
        libsForQt5.qt5.qtsvg
        qt6.qt5compat
        qt6.qtsvg
        sddm-theme.sddm-sugar-dark
        where-is-my-sddm-theme
    ];
    services = {
        xserver = {
            xrandrHeads = [
                {
                    output = "DP-1";
                    primary = true;
                }
                {
                    output = "DP-2";
                    monitorConfig = ''Option "Enable" "false"'';
                }
                {
                    output = "HDMI-A-1";
                    monitorConfig = ''Option "Enable" "false"'';
                }
            ];
            enable = true;
            xkb = {
                layout = "gb";
                variant = "";
            };
        };

        displayManager.sddm = {
            enable = true;
            wayland.enable = true;
            autoNumlock = true;
            theme = "where_is_my_sddm_theme";
        };
    };
}