{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    firefox
    kitty
    xorg.xrdb
    orca-slicer
  ];
}
