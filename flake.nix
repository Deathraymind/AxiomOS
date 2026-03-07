{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs : {

    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; 
      modules = [
        ./hosts/desktop/configuration.nix
        ./axiomosModules/programs/hyprland.nix
        ./axiomosModules/programs/defaultPrograms.nix
      ];
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; 
      modules = [
        ./hosts/laptop/configuration.nix
        ./axiomosModules/programs/hyprland.nix
        ./axiomosModules/programs/defaultPrograms.nix
      ];
    };

    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/vm/configuration.nix
        ./modules/system/default.nix
        inputs.home-manager.nixosModules.default
        {
          home-manager = {
            # This is the critical line you were missing:
            extraSpecialArgs = { inherit inputs; }; 
            users.deathraymind = import ./hosts/vm/home.nix;
          };
        }
      ];
    };
  }; 
}
