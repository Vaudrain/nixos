{ pkgs, user, lib, ... }:

{
  home.packages = with pkgs; [
    plasmusic-toolbar
    plasma-panel-colorizer
  ];

  programs.plasma = {
    enable = true;
    shortcuts = {
      "kwin"."Overview" = "Meta";
      "services/org.kde.spectacle.desktop"."_launch" = "Meta+Shift+P";
    };
    
    spectacle.shortcuts = {
      captureRectangularRegion = "Print";
    };

    configFile = {
      "kcminputrc"."Keyboard"."NumLock".value = 0;
    };

    workspace = {
      clickItemTo = "select";
      tooltipDelay = 3;
      cursor.theme = "Breeze";
      iconTheme = "candy-icons";
    };

    workspace.wallpaper = lib.cleanSource ./wallpapers/CitizenSleeper2.png;

    panels = [
      {
        location = "top";
        height = 50;
        screen = 2;
        hiding = "none";
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config.General = {
              icon = "nix-snowflake-white";
              alphaSort = true;
            };
          }
          {
            iconTasks = {
              launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:obsidian.desktop"
                "applications:firefox.desktop"
                "applications:discord.desktop"
              ];
              appearance = {
                rows = {
                  maximum = 2;
                  multirowView = "lowSpace";
                };
                showTooltips = false;
                iconSpacing = "small";
              };
            };
          }
          "org.kde.plasma.panelspacer"
          {
            plasmusicToolbar = {
              panelIcon = {
                albumCover = {
                  fallbackToIcon = true;
                  useAsIcon = true;
                  radius = 0;
                };
              };
              musicControls.showPlaybackControls = false;
              songText = {
                displayInSeparateLines = true;
                maximumWidth = 250;
                scrolling = {
                  behavior = "scrollOnHover";
                  speed = 3;
                };
              };
            };
          }          
          "org.kde.plasma.panelspacer"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.volume"
                "org.kde.plasma.notifications"
              ];
              hidden = [
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.polychromatic"
                "org.kde.plasma.brightness"
                "org.kde.plasma.battery"
                "org.kde.plasma.keyboardindicator"
                "org.kde.plasma.libdiscover"
                "org.kde.plasma.mediacontroller"
                "Yakuake"
                "remmina-icon"
                "polychromatic-tray-applet"
              ];
            };
          }
          "org.kde.plasma.digitalclock"
          {
            plasmaPanelColorizer = {
              general.hideWidget = true;
              panelBackground = {
                originalBackground = {
                  hide = true;
                  opacity = 0;
                };
                customBackground = {
                  enable = true;
                  opacity = 0.70;
                };
              };
            };
          }
        ];
      }
    ];
  };
}
