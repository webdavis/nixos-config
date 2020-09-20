{
  networking = {
    # Configure /etc/hosts file. (Appends this line to /etc/hosts on the resulting NixOS system.)
    extraHosts = { "127.0.0.1 ferrovax.localdomain.ferrovax" };

    # Configure permanent hostname.
    hostName = "ferrovax";

    # The ID was created using the following compound command: `head -c4 /dev/urandom | od -A none -t x4`.
    hostId = "509df16c";

    localCommands = ''hostnamectl set-hostname ferrovax'';

    # Configure network proxy. (This will be needed when working remote in some instances.)
    # proxy.default = "https://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Google's Public DNS Servers: https://developers.google.com/speed/public-dns/
    nameServers = [ "8.8.8.8" "8.8.4.4" ];

    networkmanager = {
      enable = true;
      wifi.powersave = true;
      # Prepend Google's DNS servers to NetworkManger's config.
      insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
    };

    # The global useDHCP flag is depcrecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behavior.
    useDHCP = false;
    interfaces.wlp4s0.useDHCP = true;
  };

  # Install and configure some helpful networking tools.
  networking.nftables.enable = true;
  programs.mtr.enable = true;
}
