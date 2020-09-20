{
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
    extraConfig =
    ''
      IdleAction=ignore
      KillUserProcesses=no
    '';
  };
}
