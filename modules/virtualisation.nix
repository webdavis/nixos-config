{ config, lib, pkgs, ...}:

{
  programs.cdemu = {
    enable = true;
    gui = true;
    image-analyzer = true;
    group = "cdrom";
  };

  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "enp0s3";
    };

    networkmanager = lib.mkIf config.networking.networkmanager.enable {
      # Prevent NetworkManager from managing libvirt interfaces.
      unmanaged = [ "interface-name:ve-*" ];
    };
  };

  # Persistent fix for IPv4 NAT. See this article:
  # https://wiki.libvirt.org/page/Guest_can_reach_host,_but_can%27t_reach_outside_network
  boot.kernel.sysctl = { "net.ipv4.ip_forward" = 1; }

  virtualisation = {
    libvirtd = {
      enable = true;
      onShutdown = "suspend";
      qemuVerbatimConfig =
      ''
      '';
    };

    virtualbox.host = {
      enable = true;
      # FIXME check if Issue still exists by setting to true.
      # VirtualBox 3D acceleration issue: https://github.com/NixOS/nixpkgs/issues/22760
      enableHardening = false;
    };

    docker = {
      enable = true;
      storageDriver = "overlay2";
    };
  };

  # Install extra virtualization tools.
  environment.systemPackages = with pkgs; [
    libguestfs
    dnsmasq
    bridge-utils
    virt-viewer
    virtmanager
    vagrant
  ];
}
