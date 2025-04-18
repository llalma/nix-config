{ config, lib, pkgs, ... }:


let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz;
  isWSL = builtins.pathExists "/proc/sys/fs/binfmt_misc/WSLInterop";
in
{
  imports = [
    (import "${home-manager}/nixos")
		./users/llalma.nix
  ]
  ++ (if isWSL then
				[ ./wsl.nix ]
			else 
				[ 
					./native.nix 
					./users/plex.nix
				]
			);
      

  system.stateVersion = "24.11"; 

	# Users in wheel dont need password for sudo
	security.sudo.wheelNeedsPassword = false;
	
	# Enable rootless docker
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };

	# Install system packages
	environment.systemPackages = [
		pkgs.dbus
		pkgs.nixos-container
	];

	# Networking
	networking.firewall.allowedTCPPorts = [ 
		32400 # Open plex port
	];

}
