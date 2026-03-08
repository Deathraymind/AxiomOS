{ lib, config, pkgs, ... }:
let
  cfg = config.axiomos.zsh;  
in 
{
  ### 1. Define the "Switch"
  options.axiomos.zsh = {
    enable = lib.mkEnableOption "AxiomOS zsh Configuration";
  };

  ### 2. The Logic (Home Manager only!)
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true; 
    };
  };
}
