{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.axiomos.starship;
in {
  ### 1. Define the "Switch"
  options.axiomos.starship = {
    enable = lib.mkEnableOption "AxiomOS starship Configuration";
  };

  ### 2. The Logic (Home Manager only!)
  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      # Starship is "Batteries Included" - it looks great out of the box
      enableZshIntegration = true;
    };
  };
}
