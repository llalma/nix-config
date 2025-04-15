{config, pkgs, lib, ...}:

{

  # Configure rootfs
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";  
    fsType = "ext4";  
  };

  boot.loader.grub = {
    enable = true;
    devices = [ "/dev/disk/by-label/nixos" ];  
  };

  # Networking
  networking.networkmanager.enable = true;
  users.users.llalma.extraGroups = [ "networkmanager" ];


}
