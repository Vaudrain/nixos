{ pkgs, user, ... }:
{
    services.xserver.displayManager.sddm.setupScript = "./scripts/Xsetup";
}