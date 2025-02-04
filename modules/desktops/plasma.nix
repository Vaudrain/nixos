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
      "kmix"."mic_mute" = ["Pause" "Microphone Mute"];
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

    workspace.wallpaper = lib.cleanSource ./wallpapers/CitizenSleeper.jpg;

    panels = [
      {
        location = "top";
        height = 50;
        screen = 1;
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
                "applications:dev.vencord.Vesktop.desktop"
              ];
              appearance = {
                rows = {
                  maximum = 2;
                  multirowView = "lowSpace";
                };
                showTooltips = false;
              };
            };
          }
          "org.kde.plasma.panelspacer"
          {
            plasmusicToolbar = {
              panelIcon = {
                albumCover = {
                  fallbackToIcon = false;
                  useAsIcon = true;
                  radius = 0;
                };
              };
              musicControls.showPlaybackControls = false;
              songText = {
                displayInSeparateLines = true;
                maximumWidth = 640;
                scrolling = {
                  behavior = "alwaysScroll";
                  speed = 3;
                };
              };
            };
          }          
          "org.kde.plasma.panelspacer"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.volume"
                "org.kde.plasma.notifications"
              ];
              hidden = [
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.polychromatic"
                "org.kde.plasma.brightness"
                "org.kde.plasma.battery"
                "org.kde.plasma.keyboardindicator"
                "org.kde.plasma.libdiscover"
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
