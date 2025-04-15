{config, pkgs, lib, ...}:

{

  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos-server";
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "FinallyNBN" = {
      pskRaw = "47c966e97407a15427a240dc758e45ab2a18a6cfd1b1904800973515734fa3aa";
    };
  };


}
