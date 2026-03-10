{
  description = "A very basic flake";

  inputs = {
    # Official Plugins Flake - forced to follow your Hyprland version
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    stylix.url = "github:danth/stylix";
    nvf-custom.url = "github:deathraymind/nvf";
    hyprland.url = "github:hyprwm/Hyprland/";

    # Add Hyprspace here pinned to the working commit
    hyprspace = {
      url = "github:KZDKM/Hyprspace"; # Pinned to the 0.53 compat commit
      inputs.hyprland.follows = "hyprland";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
        {
          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            users.deathraymind.imports = [
              ./hosts/desktop/home.nix
            ];
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
