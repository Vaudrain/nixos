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

  zramSwap = {
    enable = true;
    memoryPercent = 25;
  };


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
      forceFullCompositionPipeline = false;
      nvidiaPersistenced = true;
      # package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ libva-vdpau-driver ];
    };
  };

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "590.48.01"; # To update - change version number, try to rebuild, replace sha hashes # See https://www.nvidia.com/en-gb/geforce/drivers/ for updates
    sha256_64bit = "sha256-ueL4BpN4FDHMh/TNKRCeEz3Oy1ClDWto1LO/LWlr1ok=";
    openSha256 = "sha256-hECHfguzwduEfPo5pCDjWE/MjtRDhINVr4b1awFdP44=";
    settingsSha256 = "sha256-NWsqUciPa4f1ZX6f0By3yScz3pqKJV1ei9GvOF8qIEE=";
    persistencedSha256 = "sha256-wsNeuw7IaY6Qc/i/AzT/4N82lPjkwfrhxidKWUtcwW8=
";
  };
}
