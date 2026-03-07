{ config, lib, pkgs, inputs, ... }:

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
     extraGroups = [ "wheel" ];      
    packages = with pkgs; [
            neovim
    ];
   };

    ## Home Manager Import ##
    axiomos.steam.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "25.05"; 
}

