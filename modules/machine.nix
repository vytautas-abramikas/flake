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

  fileSystems."/mnt/sda2" = {
    device = "/dev/disk/by-uuid/e08fedfa-3132-4d0c-9617-7a96cec23d45";
    fsType = "ext4";
    options = ["rw"];
  };

  swapDevices = [];

  zramSwap = {
    enable = true;
    memoryPercent = 50;  
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
    };
  };

  hardware = {
    # The following is saved from initial configuration, might help detect new hardware
    # enableRedistributableFirmware = lib.mkDefault true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics.enable = true;
    # enableAllFirmware = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
      modesetting.enable = true;
      # powerManagement.enable = true;
      open = false;
      nvidiaPersistenced = true;
      # nvidiaSettings = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };

  services.xserver.videoDrivers = ["modesetting" "nvidia"];
}
