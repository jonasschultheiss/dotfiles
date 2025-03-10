# Git configuration for verastalder
{
  pkgs,
  lib,
  ...
}: {
  # Import common git configuration
  imports = [
    ../../modules/features/git/default.nix
  ];

  # User-specific git settings
  programs.git = {
    userName = "Vera Stalder";
    userEmail = "vera.stalder@example.com";

    # Any verastalder-specific git settings can be added here
  };
}
