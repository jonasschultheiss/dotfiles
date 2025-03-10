# User packages for verastalder
{pkgs, ...}: {
  # Add user-specific packages
  home.packages = with pkgs; [
    # Core utilities
    fd
    eza
    bat
    ripgrep
    git
    starship

    # Additional tools
    jq # JSON processor
    htop # System monitor
    tmux # Terminal multiplexer
  ];
}
