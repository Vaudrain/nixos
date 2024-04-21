{ pkgs ? import <nixpkgs> { } }:

(pkgs.buildFHSUserEnv {
  name = "DungeonDraftFhs";
  targetPkgs = pkgs:
    with pkgs; [
      alsa-lib
      libglvnd
      pulseaudio
      libGL
      zlib
      libkrb5
      stdenv.cc.cc.lib
      gnome.zenity
    ] ++ (with pkgs.xorg; [
      libX11
      libXcursor
      libXi
      libXinerama
      libXrandr
      libXrender
      libXext
    ]);
  runScript = "./Dungeondraft.x86_64";
}).env
