# homeStylix.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.axiomos.homeStylix;
in {
  ### 1. Define the "Switch"
  options.axiomos.homeStylix = {
    enable = lib.mkEnableOption "AxiomOS Home-Manager Stylix Configuration";
  };

  ### 2. The Logic
  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "WhiteSur";
        package = pkgs.whitesur-icon-theme;
      };
    };
  };
}
