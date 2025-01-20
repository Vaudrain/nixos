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

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = inputs@{ self, home-manager, plasma-manager, sddm-sugar-candy-nix, nixpkgs, nur, nix-flatpak, ... }: 

  let
    user = "vaud";
    system = "x86_64-linux";
    overlays = [
      nur.overlays.default
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
          sddm-sugar-candy-nix.nixosModules.default
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

