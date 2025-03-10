{pkgs, ...}: {
  imports = [
    # Import git configuration
    ./git
    # Import shell configuration
    ./shell.nix
  ];

  # Set user-specific variables
  home.username = "verastalder";
  home.homeDirectory = "/Users/verastalder";

  # User-specific packages
  home.packages = with pkgs; [
    home-manager # system package manager
    comma # any cli you may need
  ];

  # Note: User-specific settings for screencapture moved to darwin/macos.nix

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
