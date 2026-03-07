{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
 boot.loader = {
    grub = {
      enable = lib.mkForce true;
       efiSupport = true;
       devices = [ "nodev" ];
      configurationName = "BowOS";
      fontSize = 26;
      useOSProber = true;
    };
    efi = {
       canTouchEfiVariables = true;
      # Optional: specify EFI mount point if non-standard
       efiSysMountPoint = "/boot";
    };
  };

  boot.loader.systemd-boot.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Use the systemd-boot EFI boot loader.

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

