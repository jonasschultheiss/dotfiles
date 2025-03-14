# Main configuration for jonasschultheiss
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
    # User-specific configs

    # Feature modules
    ../../modules/features/git
    ../../modules/features/shell
    ../../modules/features/starship
  ];

  # Set basic user information - use variables from specialArgs
  home = {
    username = lib.mkDefault "jonasschultheiss";
    homeDirectory = lib.mkDefault "/Users/${config.home.username}";
    stateVersion = "22.05";
  };

  # Enable home-manager
  programs.home-manager.enable = true;
}
