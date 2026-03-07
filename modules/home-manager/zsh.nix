{ lib, config, inputs, ... }:
let
  # Update this to point to the zsh option!
  cfg = config.axiomos.zsh;  
in 
{
  ### 1. Define the "Switch"
  options.axiomos.zsh = {
    enable = lib.mkEnableOption "AxiomOS zsh Configuration";
  };

  ### 2. The Logic
  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true; 
    };
  };
}
