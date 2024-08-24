{
  description = "Vaud NixOS setup.";

  inputs = {    
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = inputs@{ self, home-manager, plasma-manager, nixpkgs, nur, nix-flatpak, ... }: 

  let
    user = "vaud";
    system = "x86_64-linux";
    overlays = [
      nur.overlay
    ];
  in
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit user;
          inherit inputs;
        };
        modules = [
          { nixpkgs.config.pkgs = nixpkgs; }
          nix-flatpak.nixosModules.nix-flatpak
          ./hosts         # default 'configuration.nix' for all hosts
          ./hosts/desktop # specific 'configuration.nix' for desktop target
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user}.imports = [
              plasma-manager.homeManagerModules.plasma-manager
              ./modules/desktops/plasma.nix
            ];
            nixpkgs.config.pkgs = nixpkgs;
            nixpkgs.overlays = overlays;
          }      
        ];
      };
    };
  };
}

