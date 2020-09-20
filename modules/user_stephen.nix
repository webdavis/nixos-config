{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    polkit
    gunpg
    rsync
    rcm
    tmux
  ];

  # Force declarative user configuration.
  users.mutableUsers = false;

  users.defaultUserShell = "/run/current-system/sw/bin/bash";

  users.extraUsers.stephen = {
    description = "Stephen A. Davis";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "users"
      "wheel"
      "sshusers"
      "audio"
      "video"
      "cdrom"
      "networkmanager"
      "libvirtd"
      "vboxusers"
      "docker"
    ];

    openssh.authorizedKeys.keys = secrets.sshKeys.stephen;
  };

  users.groups.stephen.gid = 1000;

  # Restrict process information to the owning user.
  security.hideProcessInformation = true;

  security.sudo.configFile =
  ''
    Defaults editor=/run/current-system/sw/bin/rvim

    %wheel ALL=(ALL) ALL
    Defaults:stephen !authenticate

    Defaults !tty_tickets
    Defaults timestamp_timeout=45
  '';
}
