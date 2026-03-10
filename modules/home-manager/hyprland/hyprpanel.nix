# hyprpanel.nix
{pkgs, ...}: {
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
}
