{ pkgs, user, ... }:

let
  floorp-package = pkgs.wrapFirefox pkgs.floorp-unwrapped {
    nativeMessagingHosts = [ pkgs.plasma-browser-integration (pkgs.callPackage ./floorp-profile-switcher-connector.nix { }) ]; # Profile switcher doesn't appear to work, but it's fine for now
    extraPolicies = { ExtensionSettings = { }; };
  };
in {
  home-manager.users.${user}.home.packages = with pkgs; [      
      floorp-package
    ];
}
