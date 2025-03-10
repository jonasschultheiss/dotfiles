# Main configuration for verastalder
# This file imports all other configuration files for this user
{
  pkgs,
  lib,
  ...
}: {
  # Import all configurations for this user
  imports = [
    ./home.nix # Basic home-manager settings
    ./git.nix # Git configuration
    ./starship.nix # Starship prompt configuration
    ./packages.nix # User packages
    ./shell.nix # Shell configuration

    # Keep the current utilities
    ../../modules/home/verastalder/utilities.nix
  ];

  # Set basic user information
  home = {
    username = "verastalder";
    homeDirectory = "/Users/verastalder";
    stateVersion = "22.05";
  };

  # Enable home-manager
  programs.home-manager.enable = true;
}
