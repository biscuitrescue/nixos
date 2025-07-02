{ config, pkgs, ... }: {
  imports =
    [
      ./hardware-configuration.nix
      ./modules/core.nix
      ./modules/users.nix
      ./modules/packages.nix
    ];
}
