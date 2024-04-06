{ pkgs, user, ... }:

let
  firefox-package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    nativeMessagingHosts = [ (pkgs.callPackage ./firefox-profile-switcher-connector.nix { }) ];
    extraPolicies = { ExtensionSettings = { }; };
  };
in {
  programs.firefox = {
    enable = true;
    package = firefox-package;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}
