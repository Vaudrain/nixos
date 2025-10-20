{ pkgs, lib, ... }:

let
    background-package = pkgs.stdenvNoCC.mkDerivation {
        name = "background-image";
        src = ../wallpapers/CitizenSleeperEye.png;
        dontUnpack = true;
        installPhase = ''
        cp $src $out
        '';
        };
in
{
    environment.systemPackages = with pkgs; [ 
        (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
            [General]
            background = "${background-package}"
            '')
        pkgs.xorg.xrandr
        # sddm-astronaut
        pkgs.numlockx
    ];
    services = {
        xserver = {
            enable = true;
            displayManager.setupCommands = ''
                ${pkgs.xorg.xrandr}/bin/xrandr --output DP-4 --primary --output DP-0 --off --output DP-3 --off
                '';
            xkb = {
                layout = "gb";
                variant = "";
            };
        };

        displayManager.sddm = {
            enable = true;
            autoNumlock = true;
            wayland.enable = false; # Not using wayland due to monitor constraints
            settings = { 
                General = {
                    Numlock = "on";
                };
            };
            theme = "breeze";
        };
    };
}