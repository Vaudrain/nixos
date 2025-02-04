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
            enable = true;
            displayManager.setupCommands = ''
                ${pkgs.xorg.xrandr}/bin/xrandr  --output DP-0 --primary --mode 2560x1440 --output HDMI-0 --off --output DP-3 --off
                '';
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
            wayland.enable = false; # Not using wayland due to monitor constraints
            settings = { 
                General = {
                    Numlock = "on";
                };
            };
            sugarCandyNix = {
                enable = true;
                settings = {
                    Background = lib.cleanSource ../wallpapers/CitizenSleeper2.png;
                    ScreenWidth = 2560;
                    ScreenHeight = 1400;
                    FormPosition = "center";
                    RoundCorners = 2;
                    HaveFormBackground = false;
                    PartialBlur = false;
                    ForceLastUser = true;
                    ForcePasswordFocus = true;
                    HeaderText = "";
                    BlurRadius = 10;
                };
            };
        };
    };
}