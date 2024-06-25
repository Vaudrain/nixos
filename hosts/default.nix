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
      direnv
      nix-direnv-flakes
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

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
  };

  services = {
    printing.enable = true;
    desktopManager.plasma6.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        context.properties = {
          default.clock.rate = 192000;
          default.clock.allowed-rates = "48000,88200,96000,176400,192000";
          default.clock.quantum = 1024;
          default.clock.min-quantum = 32;
          default.clock.max-quantum = 8192;
        };
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "32/192000";
              pulse.default.req = "1024/192000";
              pulse.max.req = "8192/192000";
              pulse.min.quantum = "32/192000";
              pulse.max.quantum = "8192/192000";
            };
          }
        ];
        stream.properties = {
          node.latency = "8/192000";
          resample.quality = 1;
        };
      };
    };
    mullvad-vpn = {
      enable = true;
      enableExcludeWrapper = true;
    };
    resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      dnsovertls = "true";
    };
    flatpak = {
      enable = true;
      packages = [
        "com.usebottles.bottles"
      ];
      update.auto = {
        enable = true;
        onCalendar = "daily";
      };
    };
  };

  # systemd.services.flatpak-managed-install.wantedBy = lib.mkForce [ ]; # In case this service is playing up

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
