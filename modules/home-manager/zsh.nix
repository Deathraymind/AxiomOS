{lib, config, inputs, ...}:
let
 cfg = config.axiomos.git;  
in 
{

 ### 1. Define the "Switch"
  options.axiomos.zsh= {
    enable = lib.mkEnableOption "AxiomOS zsh Configuration";
  };

  ### 2. The Logic
  config = lib.mkIf cfg.enable {

    programs = {
        zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true; 
            };
        kitty.enable = true;
        };
    };
}
