{ pkgs ? import <nixpkgs> { } }:

(pkgs.buildFHSUserEnv {
  name = "DungeonDraftFhs";
  targetPkgs = pkgs:
    with pkgs; [
      alsa-lib
      libglvnd
      pulseaudio
    ] ++ (with pkgs.xorg; [
      libX11
      libXcursor
      libXi
      libGL
      libXinerama
      libXrandr
      libXrender
      libXext
    ]);
  runScript = "./Wonderdraft.x86_64";
}).env