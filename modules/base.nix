{ pkgs, ...}:

{
  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "US/Eastern";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install programs that every machine should have.
  environment.systemPackages = with pkgs; [
    lm_sensors
    sudo
    vim
    git
    tarsnap
  ];

  hardware.intel.updateMicrocode = true;

  # Maybe this will help a bit with Lenovo ThinkPad P51 thermal issues.
  services.thermald.enable = true;
}
