{config, pkgs, lib, ...}:

{

  # Configure rootfs
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";  
    fsType = "ext4";  
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true; 
    devices = [ "nodev" ];
  };

  # Networking
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "FinallyNBN" = {
      pskRaw = "47c966e97407a15427a240dc758e45ab2a18a6cfd1b1904800973515734fa3aa";
    };
  };


}
