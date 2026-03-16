{...}: {
  imports = [
    ./desktop-logic.nix
    ./steam.nix
    ./stylix.nix
    ./applications/defaultApplications.nix
    ./cachy.nix
    ./autologin.nix
  ];
}
