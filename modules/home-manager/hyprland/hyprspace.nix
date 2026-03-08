{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.axiomos.hyprspace;
in {
  options.axiomos.hyprspace = {
    enable = lib.mkEnableOption "AxiomOS hyprspace Configuration";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      plugins = [
        pkgs.hyprlandPlugins.hyprspace
      ];

      settings = {
        bind = [
          "SUPER, Tab, overview:toggle,"
        ];
      };
    };
  };
}
