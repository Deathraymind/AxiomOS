{config, lib, ...}: 

let
  cfg = config.axiomos.hyprpaper;
in
{
### 1. Define the "Switch"
  options.axiomos.hyprpaper = {
    enable = lib.mkEnableOption "AxiomOS Hyprpaper Configuration";
  };

  ### 2. The Logic
  config = lib.mkIf cfg.enable {

    services.hyprpaper = {
        enable = true;
        settings = {
          ipc = "on";
          # If the file is named '.wallpaper.png' in your current folder:
          preload = [ "${./nixwallpaper.jpg}" ];
          
          # This applies it to all monitors using the Nix store path
          wallpaper = [ ",${./nixwallpaper.jpg}" ];
          
          splash = false;
        };
      };
  };
}
