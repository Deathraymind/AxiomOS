{ config, pkgs, lib, ... }: 
let
  cfg = config.axiomos.stylix; 
in 
{
  options.axiomos.stylix = {
    enable = lib.mkEnableOption "AxiomOS stylix Configuration";
  };

  config = lib.mkIf cfg.enable {
    # This block only works if 'inputs.stylix.nixosModules.stylix' 
    # is in your flake.nix configuration!
    stylix = {
      enable = true;
      polarity = "dark";
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/orxngc/walls-catppuccin-mocha/master/dominik-mayer-17.jpg";
        sha256 = "sha256-Ez/0PPNPg65wkb3MuWl6b0j09Y3gxpHoXxxsSGwsv1c=";
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 32;
      };

      fonts = {
        # FIXED: Use 'nerd-fonts' (hyphenated) and specific package names
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font Mono";
        };
        sansSerif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        serif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
      };

      base16Scheme = {
        base00 = "1e1e2e"; base01 = "181825"; base02 = "313244"; base03 = "45475a";
        base04 = "585b70"; base05 = "cdd6f4"; base06 = "f5e0dc"; base07 = "b4befe";
        base08 = "f38ba8"; base09 = "fab387"; base0A = "f9e2af"; base0B = "a6e3a1";
        base0C = "94e2d5"; base0D = "89b4fa"; base0E = "cba6f7"; base0F = "f2cdcd";
      };

      targets.console.enable = true;
    };
  };
}
