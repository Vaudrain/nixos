{
  description = "Vaud NixOS setup.";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
  };

  outputs = inputs@{ self, home-manager, plasma-manager, nixpkgs, ... }: 

  let
    user = "vaud";

  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit user;
          inherit inputs;
        };


        system = "x86_64-linux"; # TODO Needed?
        modules = [
          ./hosts         # default 'configuration.nix' for all hosts
          ./hosts/desktop # specific 'configuration.nix' for desktop target
          #./old-config/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
          #home-manager.users.${user} {
          #  imports = [ plasma-manager.homeManagerModules.plasma-manager ];
          #}
        ];
      };
    };
  };
}

