{config, pkgs, lib, ...}:

{
  imports = [
    <nixos-wsl/modules>
  ]

  wsl.enable = truel
  wsl.defaultUser= "llalma";

}
