{config, pkgs, lib, ...}:

{
  imports = [
    <nixos-wsl/modules>
  ]

  wsl.enable = true
  wsl.defaultUser = "llalma";

}
