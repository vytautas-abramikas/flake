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
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" "en_DK.UTF-8/UTF-8" ];
  };
  
  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    libinput.enable = true;
    openssh.enable = true;
    printing.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      xkbModel = "pc105";
      xkbLayout = "us,lt,ru";
      xkbOptions = "eurosign:e,caps:escape,grp:alt_shift_toggle,grp_led:scroll,grp:alt_shift_toggle";
    };
    displayManager.sddm = {
      enable = true;
    };
    desktopManager.plasma6 = {
      enable = true;
    };
  };

  environment = {
    variables = {
      LC_TIME = "en_DK.UTF-8";
      LC_NUMERIC = "en_DK.UTF-8";
      LC_MEASUREMENT = "en_DK.UTF-8";
    };

    systemPackages = with pkgs; [
      wget fbset hwinfo htop
    ];

    plasma6.excludePackages = with pkgs.kdePackages; [
      kate
    ];
  };

  users.users.broliux = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"];
    home = "/home/broliux";
    shell = pkgs.bash;
    packages = with pkgs; [
      tree
      git nodejs github-desktop vscodium
      firefox vlc
    ];
  };
}

