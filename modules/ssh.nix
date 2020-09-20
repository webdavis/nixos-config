{ lib, ... }:

{
  # Install SSH security modules.
  services.fail2ban.enable = true;

  # Enable the OpenSSH daemon.
  # XXX If this fails then move lib.mkForce to `enable = lib.mkForce true;`.
  services.openssh = lib.mkForce {
    enable = true;
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
    ];

    # [KEX Method and SSH Recommendations](https://tools.ietf.org/id/draft-ietf-curdle-ssh-kex-sha2-09.html)
    kexAlgorithms = [
      "curve25519-sha256@libssh.org"
      "ecdh-sha2-nistp384"
      "ecdh-sha2-nistp521"
    ];

    ciphers = [
      "chacha20-poly1305@openssh.com"
      "aes256-gcm@openssh.com"
      "aes128-gcm@openssh.com"
      "aes256-ctr"
      "aes192-ctr"
      "aes128-ctr"
    ];

    macs = [
      "hmac-sha2-512-etm@openssh.com"
      "hmac-sha2-256-etm@openssh.com"
      "umac-128-etm@openssh.com"
      "hmac-sha2-512"
      "hmac-sha2-256"
      "umac-128@openssh.com"
    ];

    # LogLevel VERBOSE logs user's key fingerprint on login. Needed to have a clear audit
    # track of which key was using to log in. (Switch to DEBUG, DEBUG2, or DEBUG3 when troubleshooting.)
    loglevel = "VERBOSE";

    # Root login is not allowed for auditing reasons. This is because it's difficult to
    # track which process belongs to which root user:
    #
    # On Linux, user sessions are tracked using a kernel-side session id, however, this
    # session id is not recorded by OpenSSH. Additionally, only tools such as systemd and
    # auditd record the process session id. On other OSs, the user session id is not
    # necessarily recorded at all kernel-side. Using regular users in combination with
    # /bin/su or /usr/bin/sudo ensure a clear audit track.
    permitRootLogin = "no";

    # Disable remote host port forwarding.
    gatewayPorts = true;

    # Enables sshfs so that remote filesystems may be mounted.
    #
    # Usage (make the directory and mount the remote filesystem):
    #
    #   sudo mkdir /mnt/<instance-name>
    #   sudo sshfs -o allow_other,defer_permissions,IdentityFile=~/.ssh/id_rsa root@xxx.xxx.xxx.xxx:/ /mnt/<instance-name>
    allowSFTP = true;

    # Log SFTP level file access (read/write/etc.) that would not be easily logged otherwise.
    sftpFlags = [ "-f AUTHPRIV" "-l INFO" ];

    # Set the port to 6040 and open it on the firewall.
    ports = [ 6040 ];
    openFirewall = true;

    challengeResponseAuthentication = true;
    passwordAuthentication = false;
    forwardX11 = false;

    extraConfig =
    ''
      Protocol 2
      AllowGroups sshusers
      AuthenticationMethods publickey,keyboard-interactive:pam
      KbdInteractiveAuthentication yes
      PubkeyAuthentication yes
      PermitEmptyPasswords no
      UsePAM yes
      PermitTunnel no
      LoginGraceTime 1m
      MaxAuthTries 6
      MaxSessions 10
      StrictModes yes
      PrintLastLog yes
      PrintMotd yes
      IgnoreRhosts yes
    '';
  };

  # Install and enable mosh shell for persistent SSH connections.
  programs.mosh.enable = true;

  # Launch gpg-agent.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # nix.sshServe.enable = true;
  # nix.sshServe.keys = [ public keys ];
}
