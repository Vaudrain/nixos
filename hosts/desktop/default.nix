{ config, pkgs, inputs, user, ... }:
{
  imports = [
    ./hardware.nix
  ];

  services.xserver.videoDrivers = ["nvidia"];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    blacklistedKernelModules = [ "nouveau"];
    kernelParams = [ "nouveau.modeset=0" "nvidia-drm.modeset=1" ];
    loader = {
      #systemd-boot.enable = true; TODO Did grub work?
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {                              
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                
        configurationLimit = 2;
      };
      timeout = 1;   
    };
  };

  sound.enable = true;

  nixpkgs.config.allowUnfree = true; # For Nvidia drivers

  hardware = {
    pulseaudio.enable = false;
    openrazer.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General.Enable = "Source,Sink,Media,Socket";
      };
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [ vaapiVdpau ];
    };
  };
}
