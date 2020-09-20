{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    # FIXME 6.6.0 Stable (6.6.0.161 is recommended, but that isn't available. Will need to
    # build a derivation by hand.
    mono6
    monodevelop
  ];
}
