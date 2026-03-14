# homeStylix.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  ### 2. The Logic
  environment.systemPackages = [
    pkgs.yazi
  ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
    ];
}
