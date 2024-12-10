{ config, lib, pkgs, ... }: 

{
  home-manager.users.broliux = { config, lib, pkgs, ... }: {
    home = {
      stateVersion = "24.11";
      username = "broliux";
      homeDirectory = "/home/broliux";

      packages = with pkgs; [
        kitty
        git nodejs github-desktop vscodium kdePackages.kcalc
        brave firefox vlc
        ventoy-full
      ];

      xsession.windowManager.i3 = {
        enable = true;
        config = {
          modifier = "Mod4";
        };
      };
    };
  };
}