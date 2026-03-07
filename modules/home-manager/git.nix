{lib, config, inputs, ...}:
let
 cfg = config.axiomos.git;  
in 
{

 ### 1. Define the "Switch"
  options.axiomos.git= {
    enable = lib.mkEnableOption "AxiomOS git Configuration";
  };

  ### 2. The Logic
  config = lib.mkIf cfg.enable {
 


programs.git = {
      enable = true;
      userName = "Deathraymind";
      userEmail = "deathraymind@gmail.com";
    };
    };
}
