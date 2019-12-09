let unstableTarball =
  fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  # Enable automatic upgrades (See: https://nixos.org/nixos/manual/index.html#sec-upgrading-automatic)
  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-19.09;

  environment.systemPackages = with pkgs; [
    vim
    unstable.neovim
    git
    python38
    python2
    python3
    # rofi
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  virtualisation.docker.enable = true;
}
