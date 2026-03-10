{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.axiomos.hyprspace;
  system = pkgs.stdenv.hostPlatform.system;
in {
  options.axiomos.hyprspace = {
    enable = lib.mkEnableOption "AxiomOS hyprspace Configuration";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      plugins = [
        inputs.hyprspace.packages.${pkgs.system}.Hyprspace
      ];

      settings = {
        bind = [
          "SUPER, Tab, overview:toggle,"
        ];
      };
    };
  };
}
