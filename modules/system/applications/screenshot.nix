{pkgs, ...}: let
  # This creates the actual logic for the snipping tool
  hypersnip = pkgs.writeShellScriptBin "hypersnip" ''
    # 1. Capture the region
    # We use a temp file to pass between grim, swappy, and tesseract
    TEMP_IMG=$(mktemp /tmp/screenshot_XXXXXX.png)

    # Select region and capture
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" "$TEMP_IMG"

    # If the user hits ESC or cancels, exit
    [ ! -s "$TEMP_IMG" ] && rm "$TEMP_IMG" && exit

    # 2. Open Swappy for the "Super Nice" GUI experience
    # -f: input file
    # -o: output file (when user clicks 'Save')
    ${pkgs.swappy}/bin/swappy -f "$TEMP_IMG" -o "$TEMP_IMG"

    # 3. Handle OCR and Clipboard
    # We check if the file still exists (Swappy might have deleted/moved it)
    if [ -f "$TEMP_IMG" ]; then
        # Copy the image itself to clipboard regardless
        cat "$TEMP_IMG" | ${pkgs.wl-clipboard}/bin/wl-copy --type image/png

        # Perform local OCR (No AI, purely local Tesseract)
        # We redirect stderr to null to keep the console clean
        TEXT=$(${pkgs.tesseract}/bin/tesseract "$TEMP_IMG" - 2>/dev/null)

        if [ ! -z "$TEXT" ]; then
            # If text is found, we can append it to the clipboard or
            # send a notification so you know it's ready to be pasted.
            echo "$TEXT" | ${pkgs.wl-clipboard}/bin/wl-copy --primary
            ${pkgs.libnotify}/bin/notify-send "OCR Successful" "Text copied to primary selection (middle click)" -i edit-paste
        fi

        # Cleanup temp file
        rm "$TEMP_IMG"
    fi
  '';
in {
  # Install the necessary dependencies
  environment.systemPackages = with pkgs; [
    grim # Screen capture
    slurp # Region selection
    swappy # GUI Editor (Save/Copy buttons)
    tesseract # OCR Engine
    wl-clipboard # Clipboard management
    libnotify # Notifications
    hypersnip # Our custom script
  ];

  # Optional: You can place your Hyprland bind here if you use
  # programs.hyprland.extraConfig, or just put it in your hyprland.conf
  /*
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, P, exec, hypersnip"
    ];
  };
  */
}
