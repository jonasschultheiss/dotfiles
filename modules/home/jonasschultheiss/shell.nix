{pkgs, ...}: {
  # Import common shell configuration
  imports = [
    ../../../common/shell
  ];

  # Additional jonasschultheiss-specific shell customizations
  programs.fish = {
    # Additional shell aliases specific to jonasschultheiss
    shellAliases = {
      # Add any jonasschultheiss-specific aliases here
    };

    # Additional jonasschultheiss-specific shell init
    shellInit = ''
      # Add any jonasschultheiss-specific shell init here

      # Configure any specific paths or environment variables
      # Example:
      # set -gx PATH "$HOME/bin" $PATH
    '';
  };

  # Customize starship prompt if needed
  programs.starship.settings = {
    # Add jonasschultheiss-specific starship customizations here
  };

  # Add jonasschultheiss-specific packages
  home.packages = with pkgs; [
    # Add any jonasschultheiss-specific packages here
  ];
}
