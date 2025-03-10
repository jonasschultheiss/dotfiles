# Configuration for the 'devenv' computer
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
      computerName = "devenv";
      hostName = "devenv";
      localHostName = "devenv";
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
      "openjdk"
    ];

    # Mac App Store applications to install
    masApps = {
    };
  };

  # Computer-specific packages to install
  home.packages = with pkgs; [];

  # Specific environment variables for this machine
  home.sessionVariables = {};
}
