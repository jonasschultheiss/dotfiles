# Main configuration for verastalder
# This file imports all other configuration files for this user
{
  pkgs,
  lib,
  config,
  currentUser,
  ...
}: {
  # Import all configurations for this user
  imports = [
    # Feature modules
    ../../modules/features/git
    ../../modules/features/shell
    ../../modules/features/starship
  ];

  # Set basic user information - use variables from specialArgs
  home = {
    username = lib.mkDefault "verastalder";
    homeDirectory = lib.mkDefault "/Users/${config.home.username}";
    stateVersion = "22.05";
  };

  # Enable home-manager
  programs.home-manager.enable = true;
}
