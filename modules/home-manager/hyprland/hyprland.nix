{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  # This makes it easier to reference your own toggle
  cfg = config.axiomos.hyprland;
in {
  ### 1. Define the "Switch"
  options.axiomos.hyprland = {
    enable = lib.mkEnableOption "AxiomOS Hyprland Composite Config";
  };

  ### 2. The Logic (Only applies if enable is true)
  config = lib.mkIf cfg.enable {
    # We can automatically install helper apps when Hyprland is on
    home.packages = with pkgs; [
      kitty
      wl-color-picker
      playerctl
      brightnessctl
    ];

    wayland.windowManager.hyprland = {
      package = lib.mkForce inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      enable = true;

      systemd.enable = false;
      settings = {
        exec-once = [];

        bind = [
          "SUPER, Q, killactive,"
          "SUPER, W, togglefloating,"
          "SUPER, A, exec, rofi -show drun"
          "ALT, return, fullscreen,"
          "SUPER, T, exec, kitty"
          "SUPER, I, exec, wl-color-picker"

          # Workspaces & Movement
          "SUPER CTRL, right, workspace, r+1"
          "SUPER CTRL, left, workspace, r-1"
          "SUPER CTRL, L, workspace, r+1"
          "SUPER CTRL, H, workspace, r-1"
          "SUPER CTRL ALT, right, movetoworkspace, r+1"
          "SUPER CTRL ALT, left, movetoworkspace, r-1"
          "SUPER CTRL ALT, L, movetoworkspace, r+1"
          "SUPER CTRL ALT, H, movetoworkspace, r-1"
          "SUPER SHIFT CONTROL, left, movewindow, l"
          "SUPER SHIFT CONTROL, right, movewindow, r"
          "SUPER SHIFT CONTROL, up, movewindow, u"
          "SUPER SHIFT CONTROL, down, movewindow, d"
        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        bindl = [
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", xf86monbrightnessup, exec, brightnessctl set 5%+"
          ", xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ];

        monitor = [
          "DP-1, 2560x1440@165, 0x0, 1"
          "HDMI-A-1, 1920x1080@70, -1920x0, 1"
          "Virtual-1, 1920x1080@60, 0x0, 1"
          "eDP-1, 1920x1080@60, 0x0, 1"
        ];

        general = {
          gaps_in = 2;
          gaps_out = 4;
          border_size = 1;
          layout = "dwindle";
        };

        decoration = {
          rounding = 8;
        };
      };
    };
  };
}
