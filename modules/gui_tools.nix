{ config, pkgs, ...}:

{
  # Install GUI tools.
  environment.systemPackages = with pkgs; [
    xclip
    xtitle
    xcape
    gitAndTools.git-hub
    networkmanagerapplet
    blueman
    polkit_gnome
    gnome3.gnome-screenshot
    keepassxc
    wireshark
    rofi
    rofi-systemd
    copyq
    anki
    keybase-gui
    alacritty
    nextcloud-client
    chromium
    yubikey-personalization-gui

    # Chat Apps.
    skypeforlinux
    zoom-us
    signal-desktop
    riot-desktop
    discord

    # Unfree/Proprietary packages.
    firefox-devedition-bin
    vscode
  ];

  nixpkgs.config.chromium = {
    jre = false;
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = false;
    enablePepperPDF = true;
  };

  # TODO add all url ids for my Chrome extensions.
  # programs.chromium.extensions = [
  #   Authy
  #   KeePassXC-Browser
  #   React Developer Tools
  #   Redux Devtools
  #   Lighthouse
  #   Send this link with Gmail
  #   The Great Suspender
  #   Feedly
  #   Feedly Notifier
  #   Calendly
  #   OneTab
  #   Zoom Scheduler
  #   Vimium
  #   HTTPS Everywhere
  #   Polisis
  #   Advanced Font Settings
  #   Save to Keep
  #   Adblock Plus
  #   GitHub Repository Size
  #   Stylus
  #   ColorZilla
  #   Google Docs Offline
  # ];

  nixpkgs.firefox-devedition-bin = {
    jre = false;
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = false;
    enablePepperPDF = false;
  };

  programs.evince.enable = true;
  programs.plotinus.enable = true;

  # Needed for GTK themes.
  environment.pathsToLink = [ "/share" ];
}
