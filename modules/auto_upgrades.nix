{
  # Enable automatic upgrades. (See https://nixos.org/nixos/manual/index.html#sec-upgrading-automatic)
  system.autoUpgrade = {
    enable = true;
    channel = https://nixos.org/channels/nixos-19.09;
  };

  # Configure garbage collection for NixOS generations.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
