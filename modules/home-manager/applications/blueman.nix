{
  pkgs,
  lib,
  ...
}: {
  # 1. Install Blueman
  home.packages = with pkgs; [
    blueman
  ];

  # 2. Enable the Bluetooth service (required for the app to work)
  # Note: This usually needs to be in your system configuration.nix too:
  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;

  wayland.windowManager.hyprland.settings = {
    # 3. Auto-start the tray applet
    exec-once = [
      "blueman-applet"
    ];

    # 4. Modern 2026 Window Rules (match: style)
    windowrule = lib.mkForce [
      # Float and size
      "match:class ^(blueman-manager)$, float on"
      "match:class ^(blueman-manager)$, size 600 400"

      # Move to top right (slightly left of pavucontrol so they don't stack perfectly)
      # Pavucontrol was at 100%-620, so we'll put this at 100%-1240 or just overlap them
      "match:class ^(blueman-manager)$, move 100%-620 60"

      "match:class ^(blueman-manager)$, pin on"
    ];
  };
}
