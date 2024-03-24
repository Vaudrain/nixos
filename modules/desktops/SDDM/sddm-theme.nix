{ pkgs }:

let
  imgLink = "https://github.com/Vaudrain/nixos/blob/main/modules/desktops/wallpapers/amirdrassil.jpg";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "0116h7qhbj4d2kh8sqvg2ha1qqancx0lk98jlzzwday6n3d2xj47";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
   '';
}