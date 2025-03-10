{
  pkgs,
  lib,
  ...
}: {
  # Import the common git configuration
  imports = [
    ../../../common/git
  ];

  # User-specific git configuration
  programs.git = {
    userName = "Vera Stalder";
    userEmail = "vera.stalder@example.com"; # Replace with actual email

    # User-specific extra configuration (will be merged with common settings)
    extraConfig = {
      # You can add Vera-specific settings here
      # For example:
      # github.user = "verastalder";
      # credential.helper = "osxkeychain";
    };

    # You can add or override aliases specific to Vera here
    # Example:
    # aliases = {
    #   custom-command = "!some-vera-specific-command";
    # };
  };
}
