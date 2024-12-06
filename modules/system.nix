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

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #	font = "Lat2-Terminus16";
  #	keyMap = "us";
  #	useXkbConfig = true; # use xkb.options in tty.
  #};
  
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
      xkb.layout = "us";
      xkb.options = "eurosign:e,caps:escape";
    };
    displayManager.sddm = {
      enable = true;
    };
    desktopManager.plasma6 = {
      enable = true;
    };
  };

  environment = {
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

