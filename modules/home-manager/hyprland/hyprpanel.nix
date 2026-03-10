# hyprpanel.nix
{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true; # Automatically starts the bar when you log in
    hyprland.enable = true; # Integrates directly with Hyprland
    overwrite.enable = true; # Ensures HM settings take priority over manual GUI changes

    # Set up your layout
    layout = {
      "bar.layouts" = {
        "0" = {
          left = ["dashboard" "workspaces" "windowtitle"];
          middle = ["media"];
          right = ["volume" "network" "bluetooth" "battery" "clock" "notifications"];
        };
      };
    };

    # Fine-tune settings (Wi-Fi, Clock, etc.)
    settings = {
      bar.workspaces.show_icons = true;
      menus.clock.time.military = true;
      menus.dashboard.stats.enable_gpu = true;
      theme.bar.transparent = true;
    };
  };
}
