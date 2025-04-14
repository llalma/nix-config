{ config, lib, pkgs, ... }:


let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz;
in
{
  imports = [
    <nixos-wsl/modules>
    (import "${home-manager}/nixos")
  ];

  wsl.enable = true;
  wsl.defaultUser = "llalma";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
    
  
  # Config for personal user
  users.users.llalma.isNormalUser = true;
  home-manager.users.llalma = { pkgs, ... }: {
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
      ".config/nvim" = {
        source = builtins.fetchGit {
          url = "https://github.com/llalma/nvim-config.git";
          ref = "master"; 
        };
        recursive = true;
      };
    };

    home.packages = with pkgs; [
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
