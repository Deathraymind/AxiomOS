{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.axiomos.hyprpaper;
in {
  # 1. Option Definition
  options.axiomos.hyprpaper = {
    enable = lib.mkEnableOption "AxiomOS Hyprpaper Configuration";
  };

  # 2. Configuration Logic
  config = lib.mkIf cfg.enable {
    # Ensure the hyprpaper package is actually installed
    home.packages = [pkgs.hyprpaper];

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = ["${./nixwallpaper.jpg}"];
        wallpaper = [",${./nixwallpaper.jpg}"];
      };
    };

    # Tell Hyprland to start hyprpaper on login
    wayland.windowManager.hyprland.settings.exec-once = [
      "hyprpaper"
    ];
  };
}
