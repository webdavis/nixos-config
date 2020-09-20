{ pkgs, ...}:

{
  services.pcscd.enable = true;
  services.udev.packages = [
    pkgs.yubikey-personalization
    pkgs.libu2f-host
  ];

  environment.systemPackages = with pkgs; [
    yubico-piv-tool
    yubikey-manager
  ];

  environment.shellInit =
  ''
    GPG_TTY="$(tty)" && export GPG_TTY
    [[ -z "$SSH_AUTH_SOCK" ]] && SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)" && export SSH_AUTH_SOCK
    gpgconf --launch gpg-agent
  '';

  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
