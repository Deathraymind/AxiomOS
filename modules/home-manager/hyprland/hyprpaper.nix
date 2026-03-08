{ config, lib, ... }:

let
  cfg = config.axiomos.hyprpaper;
in
{
  # 1. Always define the option so Nix knows it exists
  options.axiomos.hyprpaper = {
    enable = lib.mkEnableOption "AxiomOS Hyprpaper Configuration";
  };

  # 2. Apply the configuration ONLY if enabled
# 2. Apply the configuration ONLY if enabled
  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [ "${./nixwallpaper.jpg}" ];
        wallpaper = [
          {
            monitor = ""; # Leaving this empty applies it to ALL monitors
            path = "${./nixwallpaper.jpg}";
          }
        ];
      };
    };
  }; 
}
