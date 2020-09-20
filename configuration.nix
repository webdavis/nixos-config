# Run one of the following commands to get help:
# - man 5 configuration.nix
# - nixos-help (Opens https://nixos.org/nixos/manual in the browser.)

{ config, pkgs, ...}:

{
  imports = [
    # hardware-configuration.nix is generated automatically by the hardware scan.
    ./hardware-configuration.nix
    ./conf.d/default.nix
  ];

  # This value determines the NixOS release with which your system is to be compatible. In
  # order to avoid breaking some software such as database servers, you should change this
  # only after NixOS release notes say you should.
  system.stateVersion = "19.09";  # Did you read the comment?
}
