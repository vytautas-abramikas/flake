{ config, lib, pkgs, ... }:

{
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    kernelParams = ["modprobe.blacklist=nouveau" "i915.modeset=1"];
    extraModprobeConfig = "options fbcon mode_option=1366x768-32";
    loader.grub = {
      enable = true;
      device = "/dev/sda";
    };
  };

  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/502fb189-f6fe-461d-b49f-1ac3ebb24ae2";
    fsType = "ext4";
  };

  swapDevices = [];

  zramSwap = {
    enable = true;
    memoryPercent = 50;  
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  hardware = {
    # The following is saved from initial configuration, might help detect new hardware
    # enableRedistributableFirmware = lib.mkDefault true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    # graphics.enable = true;
    # enableAllFirmware = true;
    graphics = { 
      enable = true;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
        };
      };
    };
  };

  services.xserver.videoDriver = "auto";
  services.xserver.extraConfig = "Option \"PreferredMode\" \":0\"";

  # NVIDIA stuff, this doesnt work, TODO later
  # hardware.nvidia.open = false;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;  
}