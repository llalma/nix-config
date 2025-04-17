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

  # Package install
  environment.systemPackages = with pkgs; [
     wireguard-tools
  ];

    # Create config file for wireguard
  environment.etc."wireguard/wireguard.conf" = {
    text = builtins.getEnv "WIREGUARD_CONF";
    mode = "0600";
  };

  # Configure wireguard
  systemd.services.wireguard = {
    after = ["network.target"];
    wantedBy = [ "multi-user.target" ];
    environment.DEVICE = "wg0";
    path = [ pkgs.wireguard-tools ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.wireguard-tools}/bin/wg-quick up /etc/wireguard/wireguard.conf";
      ExecStop = "${pkgs.wireguard-tools}/bin/wg-quick down /etc/wireguard/wireguard.conf";
    };
  };
  networking.nat.enable = true;
  networking.nat.externalInterface = "eth0";  
  networking.nat.internalInterfaces = [ "wg0" ];

}
