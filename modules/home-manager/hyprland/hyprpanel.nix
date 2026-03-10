# hyprpanel.nix
{
  config,
  lib,
  ...
}: let
  # This makes it easier to reference your own toggle
  cfg = config.axiomos.hyprland;
in {
  ### 1. Define the "Switch"
  options.axiomos.hyprpanel = {
    enable = lib.mkEnableOption "AxiomOS hyprpanel Composite Config";
  };

  ### 2. The Logic (Only applies if enable is true)
  config = lib.mkIf cfg.enable {
    programs.hyprpanel = {
      enable = true;

      # The 'overlay.enable' and 'layout' options are likely gone
      # from the HM module to prevent recursion errors.
      # We now pass everything through the 'settings' or 'extraConfig' attributes.

      settings = {
        # This is the new way to define layout in the official module
        "bar.layouts" = {
          "0" = {
            left = ["dashboard" "workspaces" "windowtitle"];
            middle = ["media"];
            right = ["volume" "network" "bluetooth" "battery" "clock" "notifications"];
          };
        };

        # Your other settings
        bar.launcher.auto_icon = true;
        menus.clock.time.military = true;
        menus.dashboard.stats.enable_gpu = true;
        theme.bar.transparent = true;
      };
    };
    wayland.windowManager.hyprland.settings.exec-once = [
      "hyprpanel"
    ];
  };
}
