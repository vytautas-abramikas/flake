{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.11";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  time.timeZone = "Europe/Vilnius";

  i18n = { 
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = ["en_GB.UTF-8/UTF-8" "en_DK.UTF-8/UTF-8"];
  };
  
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    libinput.enable = true;
    # openssh.enable = true;
    # printing.enable = true;
    xserver = {
      enable = true;
      xkb = {
        model = "pc105";
        layout = "us,lt,ru";
        options = "grp:alt_shift_toggle,eurosign:e,caps:escape,grp_led:scroll";
      };
      desktopManager.xfce = {
        enable = true;
      };
    };
  };

  environment = {
    variables = {
      LANG="en_GB.UTF-8";
      LC_ALL="en_GB.UTF-8";
      LC_TIME = "en_GB.UTF-8";
      LC_NUMERIC = "en_DK.UTF-8";
      LC_MEASUREMENT = "en_DK.UTF-8";
    };

    systemPackages = with pkgs; [
      gptfdisk wget fbset hwinfo htop busybox tree e2fsprogs
      kdePackages.partitionmanager
      xfce.xfce4-xkb-plugin adapta-gtk-theme
    ];
  };

  users.users.broliux = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    packages = with pkgs; [
      git nodejs github-desktop vscodium
      brave firefox vlc
      ventoy-full
    ];
  };
}

