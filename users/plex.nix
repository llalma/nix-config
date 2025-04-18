{ pkgs, ...}: {

	users.users.plex= {
		isSystemUser = true;
    group = "plex";
		home = "/home/plex";
  };
	users.groups.plex = {};

	home-manager.users.plex= {

		# Ensure plex media dirs exists
		home.file."media/movies/.keep".text = "";
		home.file."media/tv_shows/.keep".text = "";

    
		home.stateVersion = "24.11";
	};

	# Allow unfree plex package
	nixpkgs.config.allowUnfree = true;

	# Mount media file system to container
	fileSystems."/media" = {
		mountPoint = "/media";
		options = [ "bind" ];
		device = "/home/plex/media"; 
	};
	
	# Configure plex
	services.plex = {
		enable = true;
		openFirewall = true;
	};
}
