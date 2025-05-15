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
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ 
      "uinput" 
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
    blacklistedKernelModules = [ "nouveau" "amdgpu" ];
    kernelParams = [ 
      "nomodeset"
      "quiet"
      "nouveau.modeset=0"
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"
      "NVreg_EnableGpuFirmware=0"
      "nvidia.NVreg_EnableGpuFirmware=0"
      "usbcore.autosuspend=-1"
      "clearcpuid=514"
      "nvidia.NVreg_OpenRmEnableUnsupportedGpus=1"
    ];
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
    plymouth.enable = true;
  };

  nixpkgs.config.allowUnfree = true; # For Nvidia drivers
  nixpkgs.config.allowUnsupportedSystem = true;
  #nixpkgs.config.cudaSupport = true; # For Cuda


  services.pulseaudio.enable = false;
  hardware = {
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
      open = true;
      nvidiaSettings = true;
      # forceFullCompositionPipeline = true;
      nvidiaPersistenced = true;
      # package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ vaapiVdpau ];
    };
  };

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "570.133.07"; # To update - change version number, try to rebuild, replace sha hashes # See https://www.nvidia.com/en-gb/geforce/drivers/ for updates
    sha256_64bit = "sha256-LUPmTFgb5e9VTemIixqpADfvbUX1QoTT2dztwI3E3CY=";
    openSha256 = "sha256-9l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
    settingsSha256 = "sha256-XMk+FvTlGpMquM8aE8kgYK2PIEszUZD2+Zmj2OpYrzU=";
    persistencedSha256 = "sha256-G1V7JtHQbfnSRfVjz/LE2fYTlh9okpCbE4dfX9oYSg8=";
  };
}
