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
      "visual-studio-code"
      "docker"
      "iterm2"
      "1password"
      "brave-browser"
      "arc"
      "rectangle"
      "slack"
    ];

    # CLI tools to install through Homebrew
    brews = [
      "nvm"
      "openjdk@17"
      "awscli"
      "hub"
    ];

    # Mac App Store applications to install
    masApps = {
      "Xcode" = 497799835;
      "Amphetamine" = 937984704;
    };
  };

  # Computer-specific packages to install
  home.packages = with pkgs; [
    # Development tools
    nodejs_20
    terraform
    ansible
    docker
    docker-compose

    # Utilities
    htop
    jq
    ripgrep
    wget
    curl

    # Languages and tools
    rustup
    go
  ];

  # Specific environment variables for this machine
  home.sessionVariables = {
    DEVENV_MACHINE = "true";
  };
}
