{ pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [ 
        pkgs.xorg.xrandr
        libsForQt5.qt5.qtquickcontrols2   
        libsForQt5.qt5.qtgraphicaleffects 
        libsForQt5.qt5.qtbase 
        libsForQt5.qt5.qtsvg
        qt6.qt5compat
        qt6.qtsvg
    ];
    services = {
        xserver = {
            xkb = {
                layout = "gb";
                variant = "";
            };
        };

        displayManager.sddm = {
            enable = true;
            package = pkgs.lib.mkForce pkgs.libsForQt5.sddm;
            extraPackages = pkgs.lib.mkForce [ pkgs.libsForQt5.qt5.qtgraphicaleffects ];
            autoNumlock = true;
            wayland.enable = true;
            setupScript = ''
                ${pkgs.numlockx}/bin/numlockx on
            '';
            sugarCandyNix = {
                enable = true;
                settings = {
                    Background = ../wallpapers/Hallowfall.jpg;
                    ScreenWidth = 2560;
                    ScreenHeight = 1400;
                    FormPosition = "center";
                    RoundCorners = 2;
                    HaveFormBackground = false;
                    PartialBlur = true;
                    ForceLastUser = true;
                    ForcePasswordFocus = true;
                    HeaderText = "";
                    BlurRadius = 10;
                };
            };
        };
    };
}