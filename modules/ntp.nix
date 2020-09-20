{
  # Configure time synchronization.
  services.openntpd = {
    enable = true;
    servers = [
      "time1.google.com"
      "time1.google.com"
      "time1.google.com"
      "time1.google.com"
    ];

    extraConfig =
    ''
      listen on 127.0.0.1
      listen on ::1
    '';
  };
}
