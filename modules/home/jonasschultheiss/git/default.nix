{
  pkgs,
  lib,
  ...
}: {
  # Import the common git configuration
  imports = [
    ../../../common/git/default.nix
  ];

  # User-specific git configuration
  programs.git = {
    userName = "Jonas Schultheiss";
    userEmail = "jonas.schultheiss@example.com"; # Replace with actual email

    # User-specific extra configuration (will be merged with common settings)
    extraConfig = {
      # You can add Jonas-specific settings here
      # For example:
      # github.user = "jonasschultheiss";
      # credential.helper = "osxkeychain";
    };

    # You can add or override aliases specific to Jonas here
    # Example:
    # aliases = {
    #   custom-command = "!some-jonas-specific-command";
    # };
  };
}
