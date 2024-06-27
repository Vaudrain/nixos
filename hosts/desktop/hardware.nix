{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd ={
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    extraModprobeConfig = ''options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1'';
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/8516d470-6600-422c-93f7-81bf1fbf1115";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B4A2-E38F";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/d043b879-f309-42b5-b184-e59ceec0ad8f"; }
    ];

  networking = {
    useDHCP = lib.mkDefault true; 
    hostName = "NixOSdesktop";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  powerManagement.cpuFreqGovernor = "performance";

  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
