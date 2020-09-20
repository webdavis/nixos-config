{ config, pkgs, ...}:

{
  sound.enable = true;

  hardware.pulseaudio = {
    package = pkgs.pulseaudioFull;
    enable = true;
    support32Bit = true
    daemon.config = {
      flat-volume = "false";

      # Default: true. (Set this to "false" to disable hot-plugging of sound cards.)
      allow-module-loading = "true";

      # Enables using --kill and --check commands on pulse. Disable for multi-user systems.
      use-pid-file = "true";
    };
  };
}
