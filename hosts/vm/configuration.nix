{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "AxiomOS"; 
  networking.networkmanager.enable = true;  

  time.timeZone = "Japan/Tokyo";

users.mutableUsers = false;
   users.users.deathraymind = {
     hashedPassword = "$y$j9T$Yu6LVySFa46PsKBHC7lkI.$fCdSJMULL1L2uOMhiY1WlR5QzW84qP42ktl2CxvSkgC";
     isNormalUser = true;
     extraGroups = [ "wheel" ];      packages = with pkgs; [
            neovim
     ];
   };
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
      
 # auto login and launch hyprland
services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Replace <your_username> with your actual user
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
      initial_session = {
        command = "Hyprland";
        user = "deathermind";
      };
    };
  };

  services.openssh.enable = true;

  system.stateVersion = "25.05"; 
}

