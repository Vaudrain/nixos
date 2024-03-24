{ pkgs, user, ... }:
{
    services.xserver = {
        enable = true;
        xkb = {
            layout = "gb";
            variant = "";
        };
        displayManager.sddm = {
            enable = true;
            autoNumlock = true;
            theme = "${import ./SDDM/sddm-theme.nix {inherit pkgs; }}";
            setupScript = "./SDDM/Xsetup.sh";
        };
    };
}