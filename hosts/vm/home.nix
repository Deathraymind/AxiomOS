{ config, pkgs, ... }:


{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "deathraymind";
  home.homeDirectory = "/home/deathraymind";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  imports = [
  ../../modules/home-manager/hyprland/hyprland.nix
  ../../modules/home-manager/hyprland/hyprspace.nix
  ../../modules/home-manager/hyprland/hyprpaper.nix
  ]; 

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
