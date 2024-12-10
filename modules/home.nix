{ config, lib, pkgs, ... }: 

{
  home-manager.users.broliux = { config, lib, pkgs, ... }: {
    home = {
      stateVersion = "24.11";
      username = "broliux";
      homeDirectory = "/home/broliux";
    
      packages = with pkgs; [
        git nodejs github-desktop vscodium kdePackages.kcalc
        brave firefox vlc
        ventoy-full
      ];
    };
  };
}