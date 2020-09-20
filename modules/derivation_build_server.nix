{
  nix = {
    buildMachines = [
      {
        hostName = "hendricks";
        sshUser = "stephen";
        sshKey = "/root/.ssh/id_yubikey_5_nano.pub";
        system = "x86_64-linux";
        maxJobs = 4;
        speedFactor = 2;
        supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
        mandatoryFeatures = [ "perf" ];
      }
    ];

    distributedBuilds = false;

    # Optional: useful when the builder has a faster internet connection than yours.
    extraOptions =
    ''
      builders-use-substitutes = true
    '';
  };
}
