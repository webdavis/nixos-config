{ config, pkgs, lib, ...}:

{
  # NixOS wants to enable GRUB by default.
  boot.loader.grub.enable = false;
  # Generate the /boot/extlinux/extlinux.conf file.
  # boot.loader.generic-extlinux-compatible.enable = true;

  # The Nix team recommends this package for the Raspberry Pi 3B+.
  boot.kernelPackages = pkgs.linuxPackages;

  # Needed for the virtual console to work on Raspberry Pi 3B+. The default is 16M, which
  # is not enough.
  boot.kernelParams = ["cma=256M"];
  boot.loader.raspberryPi.enable = true;
  boot.loader.raspberryPi.version = 3;
  boot.loader.raspberryPi.uboot.enable = true;
  boot.loader.raspberryPi.firmwareConfig = ''
    gpu_mem=256
  '';
  environment.systemPackages = with pkgs; [
    raspberrypi-tools
  ];

  # File systems configuration for using the installer's partition layout.
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  # Use 2GB of swap memory in addition to main memory (1GB), just in case.
  swapDevices = [ { device = "/swapfile"; size = 2048; } ];

  system.stateversion = "20.03";
  system.autoUpgrade = {
    enable = true;
    channel = https://nixos.org/channels/nixos-20.03;
  };

  # Preserve space by sacrificing documentation and history.
  documentation.nixos.enable = false;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
  boot.cleanTmpDir = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "US/Eastern";

  # Ensure the WiFi driver is turned on.
  networking.wireless.enable = true;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = true;

  # Force declarative user configuration.
  users.mutableUsers = false;
  users.defaultUserShell = "/run/current-system/sw/bin/bash";

  users.extraUsers.root = {
    hashedPassword = "$6$EtUxaUjlEoS$WVALF37SfHFHhAlENtSAnkrVGMfdH2mkdOrW4MOxf6zGD08jCEC0UtZs7HG7KuaPP.EFenVCEOw75VBoqKSSF.";
  }

  users.extraUsers.stephen = {
    hashedPassword = "$6$0wxpW.c4A9PX5H$YySlU40EMPUDi2JQER4u7z5/1waQP2zmyKEwI1UIw3bor5FzhWZQ9TlvvjUBIsm77UhMUTpJm2VsEq.sRaPaa/";
    description = "Stephen A. Davis";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ];

  users.groups.stephen.gid = 1000;
}
