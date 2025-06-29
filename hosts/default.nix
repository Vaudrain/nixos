{ config, lib, pkgs, inputs, user, ... }:
{
  imports = import ../modules;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "audio" "camera" "networkmanager" "video" "wheel" "openrazer" "docker" "plugdev" "user-with-access-to-virtualbox" "libvirtd" "kvm" ];
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
      protontricks
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
      attr
      earlyoom
    ];
    variables = {
      KWIN_DRM_DISABLE_TRIPLE_BUFFERING = 1;
      TZDIR = lib.mkDefault "/usr/share/zoneinfo";
    };
  };

  programs = {
    dconf.enable = true;
    gamemode.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        wineWowPackages.staging
        wineWowPackages.waylandFull
        wineWow64Packages.waylandFull
        # Add any missing dynamic libraries for unpackaged programs
        # here, NOT in environment.systemPackages
      ];
    };
  };

  fonts.fontDir.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
  };

  systemd.services.fix-behringer-audio = {
    enable = true;
    description = "Fixes behringer audio interface suspend bug";
    unitConfig = {
      type = "simple";
      after = "lock.target";
    };
    serviceConfig = {
      User = "root";
      Type = "oneshot";
      ExecStartPre= "sleep 5";
      ExecStart = "udevadm trigger -c change";
      TimeoutSec= "0";
    };
    wantedBy = [ "lock.target" ];
  };

  services = {
    printing.enable = true;
    desktopManager.plasma6.enable = true;
    libinput.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire = {
        context.properties = {
        default.clock.rate = 192000;
        default.clock.allowed-rates = "48000,88200,96000,176400,192000";
        };
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "512/192000";
              pulse.default.req = "1024/192000";
              pulse.max.req = "8192/192000";
              pulse.min.quantum = "512/192000";
              pulse.max.quantum = "8192/192000";
            };
          }
        ];
        stream.properties = {
          node.latency = "8/192000";
          resample.quality = 1;
        };
      };
      wireplumber = {
        enable = true;
        extraConfig = {
          "hide-GA102" = {
            "monitor.alsa.rules" = [
              {
                "matches" = [
                  {
                    "node.name" = "alsa_output.pci-0000_01_00.1.pro-output-3";
                  }
                  {
                    "node.name" = "alsa_output.pci-0000_01_00.1.pro-output-8";
                  }
                  {
                    "node.name" = "alsa_output.pci-0000_01_00.1.pro-output-9";
                  }
                ];
                "actions" = {
                  "update-props" = {
                    "node.disabled" = "true";
                  };
                };
              }
            ];
          };
        };
      };
    };
    mullvad-vpn = {
       enable = true;
       enableExcludeWrapper = true;
       package = pkgs.mullvad-vpn;
     };
    # resolved = {
    #   enable = true;
    #   dnssec = "true";
    #   domains = [ "~." ];
    #   fallbackDns = [
    #     "1.1.1.1"
    #     "1.0.0.1"
    #   ];
    #   dnsovertls = "true";
    # };
    flatpak = {
      enable = true;
      update = {
        onActivation = true;
        auto = {
          enable = true;
          onCalendar = "daily";
        };
      };
    };
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    package = pkgs.nixVersions.stable;
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  system = {
    stateVersion = "23.11"; # Do not change this - it should remain at the version first installed.
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
