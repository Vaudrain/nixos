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
    kernelModules = [ "kvm-amd" "snd-usb-audio" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
        options snd_usb_audio implicit_fb=1 lowlatency=0
      '';
  };

  fileSystems."/" =
    { 
      device = "/dev/disk/by-uuid/411db3b4-242b-4645-bccc-7390078e4df5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { 
      device = "/dev/disk/by-uuid/C035-69F7";
      fsType = "vfat";
    };

  fileSystems."/run/media/Windows" = 
    {
      device = "/dev/disk/by-uuid/14BA16C7BA16A4F0";
      fsType = "ntfs";
    };

  swapDevices =
    [ 
      { device = "/dev/disk/by-uuid/15092f37-7643-445e-9d08-7aef40d42ed2"; }
    ];

  networking = {
    useDHCP = lib.mkDefault true; 
    hostName = "NixOSdesktop";
    networkmanager.enable = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";
  powerManagement.cpuFreqGovernor = "performance";

  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  hardware.steam-hardware.enable = true;
}
