{ pkgs, lib, ...}:

{
  services.postgresql = {
    enable = true;
    # Trying this out instead of the following:
    # package = pkgs.unstable.postgresql_12; and
    # authentication = lib.mkForce ''
    package = pkgs.unstable.postgresql_12;
    authentication = lib.mkForce ''
      # Generated file; do not edit!
      # TYPE  DATABASE  USER      ADDRESS       METHOD
      local   all       postgres                peer
    '';
  };
}
