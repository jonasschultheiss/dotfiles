# Git configuration for verastalder
{
  pkgs,
  lib,
  ...
}: {
  # User-specific git settings
  programs.git = {
    userName = "Vera Stalder";
    userEmail = "vera.stalder@example.com";

    # Add any verastalder-specific git settings here
    # For example, signing keys or custom templates
  };
}
