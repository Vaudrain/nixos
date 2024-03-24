{ config, lib, pkgs, inputs, user, ... }:
{
  imports = import ../modules;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "audio" "camera" "networkmanager" "video" "wheel" "openrazer" "docker" "plugdev" ];
  };

  time.timeZone = "Europe/London";
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.UTF-8";
      LC_IDENTIFICATION = "en_GB.UTF-8";
      LC_MEASUREMENT = "en_GB.UTF-8";
      LC_MONETARY = "en_GB.UTF-8";
      LC_NAME = "en_GB.UTF-8";
      LC_NUMERIC = "en_GB.UTF-8";
      LC_PAPER = "en_GB.UTF-8";
      LC_TELEPHONE = "en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  console = {
    keyMap = "uk";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      easyeffects
      wget
      ripgrep
      wine
      winetricks
      wineWowPackages.staging
      wineWowPackages.waylandFull
      fd
      unzip
      p7zip
      unrar
      zip
      git
      nano
      libnotify
      openrazer-daemon
    ];
  };

  programs = {
    dconf.enable = true;
    gamemode.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged programs
        # here, NOT in environment.systemPackages
      ];
    };
  };

  services = {
    blueman.enable = true;
    printing.enable = true;
    desktopManager.plasma6.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        context.properties = {
          default.clock.rate = 48000;
          default.clock.quantum = 1024;
          default.clock.min-quantum = 1024;
          default.clock.max-quantum = 1024;
        };
      };
    };
    mullvad-vpn.enable = true;
    flatpak.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  system = {
    stateVersion = "23.11"; # Did you read the comment?
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      flake = "github:Vaudrain/nixos";
      flags = [
        "--recreate-lock-file"
        "--no-write-lock-file"
        "-L" # print build logs
       ];
      dates = "daily";
    };
  };

  home-manager.users.${user} = {
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
  };
}
