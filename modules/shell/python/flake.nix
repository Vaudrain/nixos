## Add to any Python project directory and run nix develop (or use direnv)

{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShellNoCC {
          packages = with pkgs.${system}; [
            poetry
            python3
            virtualenv
          ];
          shellHook = ''
          echo "Testing - activating venv"
          VENV=.venv
          if test ! -d $VENV; then
            virtualenv $VENV
          fi
          source ./$VENV/bin/activate
          '';
        };
      });
    };
}