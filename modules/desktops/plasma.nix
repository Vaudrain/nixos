{ pkgs, user, ... }:
{
  programs.plasma = {
    enable = true;
    shortcuts = {
      "kwin"."Overview" = "Meta";
    };

    configFile = {
      "kwinrc"."ModifierOnlyShortcuts"."Meta" = "org.kde.kglobalaccel,/component/kwin,org.kde.kglobalaccel.Component,invokeShortcut,Overview";
    };

    workspace = {
      clickItemTo = "select";
      tooltipDelay = 5;
      theme = "breeze-dark";
      colorScheme = "BreezeDark";
      # wallpaper = "./wallpapers/amirdrassil.png"; #TODO Not sure how to do this, not major
    };
    
    spectacle.shortcuts = {
      captureRectangularRegion = "Print";
    };
  };
}
