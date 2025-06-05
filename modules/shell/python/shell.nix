# Example

{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell
{
  nativeBuildInputs = with pkgs; [
    poetry
    python3
    virtualenv
  ];

  shellHook = ''
  echo "Python development environment entered."
  VENV=.venv
  if test ! -d $VENV; then
    virtualenv $VENV
  fi
  source ./$VENV/bin/activate
  '';

}
