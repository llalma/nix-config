{ config, lib, pkgs, modulesPath, ... }:

{
  imports = 
  [ (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhic_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/45ca7616-af16-4be8-968a-89031551cb13";
      fsType = "ext4";
    };
  
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9A6D-E04F";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
