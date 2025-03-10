# Configuration for the 'devenv-pax' computer
{
  pkgs,
  lib,
  config,
  ...
}: {
  # Computer-specific system configuration
  system = {
    # Computer name, host name, etc.
    networking = {
      computerName = "devenv-pax";
      hostName = "devenv-pax";
      localHostName = "devenv-pax";
    };
  };

  # Computer-specific homebrew packages
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    # GUI applications to install through Homebrew Cask
    casks = [
    ];

    # CLI tools to install through Homebrew
    brews = [
      "openjdk@17"
    ];

    # Mac App Store applications to install
    masApps = {
    };
  };

  # Computer-specific packages to install
  home.packages = with pkgs; [
  ];

  # Specific environment variables for this machine
  home.sessionVariables = {
  };
}
