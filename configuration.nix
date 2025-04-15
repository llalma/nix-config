{ config, lib, pkgs, ... }:


let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz;
in
{

  lib.mkIf (builtins.pathExists "/proc/sys/fs/binfmt_misc/WSLInterop") {
    imports = [
      <nixos-wsl/modules>
    ];
    wsl.enable = true;
    wsl.defaultUser = "llalma";
  };

  imports = [
    (import "${home-manager}/nixos")
  ];


  system.stateVersion = "24.11"; 
  
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
