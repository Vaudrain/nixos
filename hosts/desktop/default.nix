{ config, pkgs, inputs, user, ... }:
{
  imports = [
    ./hardware.nix
  ];

  services.xserver.videoDrivers = ["nvidia"];

  boot = {
    kernelPackages = pkgs.linuxPackages;
    blacklistedKernelModules = [ "nouveau"];
    kernelParams = [ "nomodeset" "nouveau.modeset=0" "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" "NVreg_EnableGpuFirmware=0" "nvidia.NVreg_EnableGpuFirmware=0" ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {                              
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;                
        configurationLimit = 15;
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
      #package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ vaapiVdpau ];
    };
  };

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "555.42.02";
    sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
    sha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
    openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
    settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA="; 
    persistencedSha256 = "sha256-3ae31/egyMKpqtGEqgtikWcwMwfcqMv2K4MVFa70Bqs=";
  };
}
