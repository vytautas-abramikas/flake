{ config, lib, pkgs, ... }: 

{
  home = {
    username = "broliux";
    homeDirectory = "/home/broliux";
  
    packages = with pkgs; [
      git nodejs github-desktop vscodium kdePackages.kcalc
      brave firefox vlc
      ventoy-full
    ];
  };
}