{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ...} @ inputs : {

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
  };
}
