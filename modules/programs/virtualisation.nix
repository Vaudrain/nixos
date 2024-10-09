{ pkgs, user, ... }:


{
  virtualisation = {
    docker.enable = true;
    virtualbox.host = {
      enable = true;
      enableExtensionPack = true;
      enableKvm = true;
      addNetworkInterface = false;
    };
    libvirtd.enable = true;
  };

  programs.virt-manager.enable = true;

  home-manager.users.${user} = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
    home.packages = with pkgs; [
      virt-manager
      virtualbox
      libvirt-glib
      looking-glass-client
      qemu_kvm
    ];
  };
}