{ pkgs, ...}:

{
  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";

    # Configure xfce as the DM. (GUIs are underrated.)
    desktopManager = {
      default = "xfce";
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
        thunarPlugins = [
          pkgs.xfce.thunar-archive-plugin
          pkgs.xfce.thunar-volman
        ];
      };
    };

    # Use i3 as the WM.
    windowManager.i3 = {
      package = pkgs.i3-gaps;
      enable = true;
      extraPackages = with pkgs; [
        i3status
        i3lock-fancy
        i3blocks-gaps
      ];
    };

    displayManager = {
      lightdm.enable = true;
      sessionCommands = "setxkbmap -keycodes media";
    };

    libinput = {
      # Enable the touchpad.
      enable = true;
      # Disable tap to click.
      tapping = false;
    };

    # Configure the keyboard.
    extraLayouts.us-en = {
      description = "US custom layout";
      languages = [ "eng" ];
      symbolsFile = /etc/nixos/conf.d/files/us-custom;
    };
    autoRepeatDelay = 200;
    autoRepeatInterval = 60;

    # Unfortunately, I have a dedicated graphics card on my laptop.
    videoDrivers = [ "nvidia" ];
  };

  hardware.opengl = {
    driSupport = true;
    extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
      vaapiVdpau
    ];

    # Enable OpenGL for 32-bit programs.
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiIntel
      libvdpau-va-gl
      vaapiVdpau
    ];
  };

  # Composite manager that fixes screen tearing in i3.
  services.compton = {
    enable = true;
    backend = "glx";
    vSync = true;
    fade = false; inactiveOpacity = "1.0";
    shadow = true;
    fadeDelta = 4;
  };

  # Intalls Light, a backlight control program. Only users in the "video" group can use this.
  programs.light.enable = true;

  # Persistent gtk3 settings.
  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf ];
}
