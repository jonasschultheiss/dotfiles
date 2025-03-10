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
      "visual-studio-code"
      "docker"
      "iterm2"
      "1password"
      "brave-browser"
      "arc"
      "rectangle"
      "slack"
      "figma"
      "figma-agent"
      "notion"
    ];

    # CLI tools to install through Homebrew
    brews = [
      "nvm"
      "openjdk@17"
      "awscli"
      "hub"
      "postgresql@14"
    ];

    # Mac App Store applications to install
    masApps = {
      "Xcode" = 497799835;
      "Amphetamine" = 937984704;
      "Final Cut Pro" = 424389933;
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
    python310
    python310Packages.pip

    # Additional tools for devenv-pax
    kubernetes-helm
    kubectl
    k9s
  ];

  # Specific environment variables for this machine
  home.sessionVariables = {
    DEVENV_PAX_MACHINE = "true";
    JAVA_OPTS = "-Xms512m -Xmx4096m";
    POSTGRES_HOST = "localhost";
  };
}
