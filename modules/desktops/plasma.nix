{ pkgs, user, ... }:
{
  programs.plasma = {
    enable = true;
    shortcuts = {
      "kwin"."Overview" = "Meta";
      "kmix"."mic_mute" = ["Pause" "Microphone Mute"];
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
      cursorTheme = "Breeze";
      iconTheme = "candy-icons";
    };

    workspace.wallpaper = ./wallpapers/amirdrassil.jpg;

    panels = [
      {
        height = 44;
        alignment = "center";
        hiding = "dodgewindows";
        minLength = 0;
        maxLength = 2500;
        screen = 1;
        floating = true;
        location = "bottom";
        widgets = [
          "org.kde.plasma.kickoff"
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General.launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:firefox.desktop"
                "applications:vesktop.desktop"
              ];
            };
          }
        ];
      }
      {
        location = "top";
        height = 36;
        screen = 0;
        hiding = "none";
        widgets = [
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.marginsseperator"
        ];
      }
    ];
  };
}
