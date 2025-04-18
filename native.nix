{config, pkgs, lib, ...}:


{

  imports = [
    ./hardware-configuration.nix
		./nginx.nix
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

	
	# Allows exposing containers over network
	networking.nat = {
		enable = true;
		# Use "ve-*" when using nftables instead of iptables
		internalInterfaces = ["ve-+"];
		externalInterface = "eth0";
		# Lazy IPv6 connectivity for the container
		enableIPv6 = true;
	};

	networking.firewall.allowedTCPPorts = [80 443];

  # Package install
  environment.systemPackages = with pkgs; [
     wireguard-tools
  ];

  # Start SSHD
  services.openssh = {
    enable = true;
  };
  

	###
	# VPN Config
	###
  # Create config file for wireguard
  environment.etc."wireguard/privatekey" = {
    text = builtins.getEnv "WIREGUARD_PRIVATE_KEY";
    mode = "0600";
  };
	
	networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "100.119.66.95/32" ];
      dns = ["10.255.255.3"] ;
      privateKeyFile = "/etc/wireguard/privatekey";
      
      peers = [
        {
          publicKey = "sDDXsvjyVqpB8fecUsjX0/Y8YdZye+oiV1Dy9BfUkwE=";
          presharedKey = "1EDNSdxzbdnB48exicuaLKiv6xnJa8SXDxPXSHR4Mls=";
          allowedIPs = [ "0.0.0.0/0" "::/0" ];
          endpoint = "mel-224-wg.whiskergalaxy.com:443";
          persistentKeepalive = 25;
        }
      ];
    };
  };
   
}
