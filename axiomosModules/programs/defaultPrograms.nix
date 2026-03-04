{inputs, pkgs}: {

  environment.systemPackages = with pkgs; [
    git 
    neovim 
    firefox
    kitty
  ];



}
