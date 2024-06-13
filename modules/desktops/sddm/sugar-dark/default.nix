{ stdenv, fetchFromGitHub }:
{
  sddm-sugar-dark = stdenv.mkDerivation rec {
    pname = "sddm-sugar-dark-theme";
    version = "1.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
    '';
    src = fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
    };
  };
}

# {pkgs}: let
#   image = pkgs.fetchurl {
#     url = "https://github.com/Vaudrain/nixos/blob/main/modules/desktops/wallpapers/amirdrassil.jpg";
#     sha256 = "0n5ayqq43hyqm9dnlqlivy4wyldgaq0apcr4lckqz3nkigdisdx3";
#   };
# in
#   pkgs.stdenv.mkDerivation {
#     pname = "sugar-dark";

#     src = pkgs.fetchFromGitHub {
#       owner = "MarianArlt";
#       repo = "sddm-sugar-dark";
#       rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
#       sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
#     };
#     installPhase = ''
#       mkdir -p $out
#       cp -R ./* $out/
#       cd $out/
#       rm Background.jpg
#       cp -r ${image} $out/Background.jpg
#     '';
#   }