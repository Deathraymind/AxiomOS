{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    inputs.hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ...} @ inputs : {

    nixosConfiguration.desktop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; 
      modules = [
        ./hosts/desktop/configuration.nix
        ./axiomosModules/hyprland.nix
      ];
    };
    nixosConfiguration.laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; 
      modules = [
        ./hosts/laptop/configuration.nix
        ./axiomosModules/hyprland.nix
      ];
    };
  };
}
