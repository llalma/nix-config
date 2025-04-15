{config, pkgs, lib, ...}:

{

  fileSystems."/" = {
    device = "/dev/disk/by-label/sda1";  
    fsType = "ext4";  
  };

  boot.loader.grub = {
    enable = true;
    devices = [ "/dev/sda1" ];  
  };

  wsl.enable = truel
  wsl.defaultUser= "llalma";

}
