# homeStylix.nix
{ config, pkgs, lib, inputs, ... }:
let
   cfg = config.axiomos.steam; 
in 
{
imports = [

  ];

 ### 1. Define the "Switch"
  options.axiomos.steam= {
    enable = lib.mkEnableOption "AxiomOS steam Configuration";
  };

  ### 2. The Logic
  config = lib.mkIf cfg.enable {
    programs.steam = {
        enable = true;

        }; 

    };
}
