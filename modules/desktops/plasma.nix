{ pkgs, user, lib, ... }:

{
  home.packages = with pkgs; [
    plasmusic-toolbar
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
        height = 36;
        screen = 1;
        hiding = "none";
        widgets = [
          "org.kde.plasma.kickoff"
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General.launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:obsidian.desktop"
                "applications:one.ablaze.floorp.desktop"
                "applications:vesktop.desktop"
              ];
            };
          }
          "org.kde.plasma.panelspacer"
          "plasmusic-toolbar"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };
}
