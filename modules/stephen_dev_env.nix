{ config, lib, pkgs, ...}:

{
  # Create an alias for the unstable channel. From: https://github.com/NixOS/nixpkgs/issues/25880#issuecomment-322855573
  nixpkgs.config = {

    # Enable proprietary/unfree packages. (Note: this includes packages that don't use an opensource license, as well.)
    allowUnfree = true;

    packageOverrides = pkgs: {
      # Pass nixpkgs.config to the unstable alias to ensure `allowUnfree` is propagated.
      unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
    };
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk11;
  };

  # Install Node Package Manager (NPM).
  programs.npm.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    python2
    python3
    python38
    yarn
    expect
    python37Packages.pexpect
    gcc
    nixops
    nix-bash-completion
    gradle-completion
    tree
    zip
    unzip
    lsof
    bind  # Installs nslookup & dig.
    netcat
    socat
    nmap
    fzf
    jq
    ripgrep
    ripgrep-all
    ngrok
    ctags
    sqlite
    keybase
    unstable.neovim
    strace
    asciinema
    google-cloud-sdk
    weechat

    # Java Profilers.
    visualvm
    jmeter
  ];

  programs.autojump.enable = true;

  programs.bash.enableCompletion = true;

  environment.variables {
    VISUAL = "nvim";
    EDITOR = "nvim";
    JSHELLEDITOR="$(which nvim)"
  };
}
