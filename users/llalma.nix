{ pkgs, ...}: {

	users.users.llalma = {
		isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

	home-manager.users.llalma = {

    programs.bash.enable = true;
    programs.git = {
      enable = true;
      userName = "llalma";
      userEmail = "llalma@gmail.com";
    };
    programs.lazygit.enable = true;
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
    };
 
    # Configure neovim
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = "";
    };


    home.file = {
		# Nvim config
      ".config/nvim" = {
        source = builtins.fetchGit {
          url = "https://github.com/llalma/nvim-config.git";
          ref = "master"; 
        };
        recursive = true;
      };
      
    };

    home.packages = with pkgs; [

      # Packages for zellij
      gcc
      gnumake

    ];

    programs.zellij = {
      enable = true;
      enableBashIntegration = true;
      settings = {
      	attachExistingSession = true;
      	exitShellOnExit = true;
      };
    };


    
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.11";

		};

}
