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
    xserver = {
      enable = true;
      videoDrivers = ["i915"];
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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable pulseaudio sound (now using pipewire).
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.broliux = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" "networkmanager"]; # Enable ‘sudo’ for the user.
    home = "/home/broliux";
    shell = pkgs.bash;
    packages = with pkgs; [
      tree
      git nodejs github-desktop vscodium
      firefox vlc
    ];
  };
}

