{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  time.timeZone = "Europe/Vilnius";

  i18n = { 
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [ "en_GB.UTF-8/UTF-8" "en_DK.UTF-8/UTF-8" ];
  };
  
  # credential manager block
  security.pam.services.lightdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    # libinput.enable = true;
    # openssh.enable = true;
    # printing.enable = true;
    xserver = {
      enable = true;
      xkb = {
        model = "pc105";
        layout = "us,lt";
        options = "grp:alt_shift_toggle,eurosign:e,caps:escape,grp_led:scroll";
      };
      displayManager.lightdm = {
        enable = true;
        background = "/usr/share/backgrounds/network-3d-background.png";
        greeters.gtk = { 
          enable = true;
          theme.name = "Dracula";
          extraConfig = "xft-dpi = 96";
        };
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
      xfce.xfce4-xkb-plugin dracula-theme papirus-icon-theme menulibre
    ];

    xfce.excludePackages = with pkgs; [
      xfce.parole
    ];
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ 
      thunar-archive-plugin thunar-volman
    ];
  };

  # fonts.packages = with pkgs; [];

  users.users.broliux = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      git nodejs github-desktop vscodium
      brave firefox transmission_4-gtk
      ventoy-full
      libreoffice-fresh qalculate-gtk
      vlc
    ];
  };
}

