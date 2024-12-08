{ config, lib, pkgs, ... }:

{
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    kernelParams = ["modprobe.blacklist=nouveau"];
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/79e3587e-956a-406c-8075-8b6c6ab6240c";
    fsType = "ext4";
  };

    fileSystems."/mnt/sda3" = {
    device = "/dev/disk/by-uuid/84fc3d90-b5ee-40eb-b8da-0b3e02d3dd2e";
    fsType = "ext4";
    options = ["rw"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0FFC-E9D6";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
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
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics.enable = true;
    enableAllFirmware = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
      modesetting.enable = true;
      open = false;
      nvidiaPersistenced = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        sync.enable = true;
      };
    };
  };

  services.xserver.videoDrivers = ["i915" "nvidia"];
}
