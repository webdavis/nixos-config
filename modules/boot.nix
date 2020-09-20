{
  boot = {
    loader = {
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };

      efi.canTouchEfiVariables = true;
    };

    kernelParams = [ "intel_pstate=no_hwp" "consoleblank=0" ];
    kernelModules = [ "kvm-intel" "virtio" "br_netfilter" "msr" "coretemp" ];
    kernel.sysctl = {
      "fs.inotify.max_user_watches"   = 1048576;  # Default: ####### (Note: inotify watches consume 1kB on 64-bit machines.)
      "fs.inotify.max_user_instances" =    1024;  # Default:
      "fs.inotify.max_user_events"    =   32768;  # Default:
    };

    initrd.luks.devices = [{
        name = "cryptlvm";
        device = "/dev/disk/by-uuid/B83B-DEFC";
        preLVM = true;
        allowDiscards = true;
      }
    ];

    cleanTmpDir = true;
  };
}
