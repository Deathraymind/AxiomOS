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
nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs; };
  modules = [
    ./hosts/vm/configuration.nix
    ./axiomosModules/programs/hyprland.nix
    ./axiomosModules/programs/defaultPrograms.nix

    # Fix: Correctly nesting the VM-specific settings
    ({ pkgs, ... }: {
      virtualisation.vmVariant = {
        # Enable 3D acceleration for the VM display
        virtualisation.qemu.options = [
          "-device" "virtio-vga-gl"
          "-display" "sdl,gl=on,show-cursor=off"
          # Audio passthrough
          "-audiodev" "pipewire,id=audio0"
          "-device" "intel-hda"
          "-device" "hda-output,audiodev=audio0"
        ];

        # Crucial environment variables for VM compatibility
        environment.sessionVariables = {
          WLR_NO_HARDWARE_CURSORS = "1";       # Prevents invisible/broken cursor
          WLR_RENDERER_ALLOW_SOFTWARE = "1";   # Fallback if virtio-gl fails
        };
      };
      
      # Ensure hardware acceleration is enabled in the guest
      hardware.graphics.enable = true; 
    })
  ];
};


    }; 
}
