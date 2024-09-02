{ config, pkgs, inputs, user, lib, ... }:
{
  imports = [
    ./hardware.nix
  ];

  services.xserver.videoDrivers = ["nvidia"];
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0666", GROUP="users", OPTIONS+="static_node=uinput"
  '';

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = [ "uinput" ];
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
        memtest86.enable = true;
      };
      timeout = 1;   
    };
  };

  nixpkgs.config.allowUnfree = true; # For Nvidia drivers
  #nixpkgs.config.cudaSupport = true; # For Cuda


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
      powerManagement.enable = false;
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
    version = "560.35.03";

    sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
    sha256_aarch64 = lib.fakeSha256;
    openSha256 = lib.fakeSha256;
    settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
    persistencedSha256 = "sha256-E2J2wYYyRu7Kc3MMZz/8ZIemcZg68rkzvqEwFAL3fFs=";
  };
}
