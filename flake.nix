{
  description = "A very basic flake";

  inputs = {
    # Official Plugins Flake - forced to follow your Hyprland version
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stylix.url = "github:danth/stylix";
    nvf-custom.url = "github:deathraymind/nvf";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/desktop/configuration.nix
        ./modules/system/default.nix
        ./modules/programs/defaultPrograms.nix
        inputs.home-manager.nixosModules.default
        inputs.stylix.nixosModules.stylix
        inputs.hyprpanel.homeManagerModules.hyprpanel
        {
          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            users.deathraymind = import ./hosts/desktop/home.nix;
          };
        }
      ];
    };

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/laptop/configuration.nix
        ./axiomosModules/programs/hyprland.nix
        ./axiomosModules/programs/defaultPrograms.nix
      ];
    };

    nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/vm/configuration.nix
        ./modules/system/default.nix
        inputs.home-manager.nixosModules.default
        {
          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            users.deathraymind = import ./hosts/vm/home.nix;
          };
        }
      ];
    };
  };
}
