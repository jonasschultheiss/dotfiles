# Git configuration for jonasschultheiss
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
    userName = "Jonas Schultheiss";
    userEmail = "jonas.schultheiss@example.com";

    # Any jonasschultheiss-specific git settings can be added here
  };
}
