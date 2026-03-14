{pkgs, ...}: {
  # Install the package
  home.packages = with pkgs; [
    pavucontrol
  ];

  # Define the window rules specifically for pavucontrol
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Float the window
      "float, class:(org.pulseaudio.pavucontrol)"

      # Set the size (Width Height)
      "size 600 400, class:(org.pulseaudio.pavucontrol)"

      # Position it in the top right
      # 100% - 620px (window width + margin) and 20px from the top
      "move 100%-620 20, class:(org.pulseaudio.pavucontrol)"

      # Optional: Make it stick to the screen even if you switch workspaces
      "pin, class:(org.pulseaudio.pavucontrol)"
    ];
  };
}
