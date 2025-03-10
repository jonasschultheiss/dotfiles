# Shell configuration for jonasschultheiss
{
  pkgs,
  lib,
  ...
}: {
  # Import common shell configuration
  imports = [
    ../../modules/features/shell/default.nix
  ];

  # User-specific shell configuration
  programs.fish = {
    # Additional shell aliases specific to jonasschultheiss
    shellAliases = {
      # Modern command-line tools
      git = "hub";
      ls = "eza";
      cat = "bat";
      find = "fd";

      # ls shortcuts
      l = "ls -l";
      ll = "ls -la";

      # Common utilities
      tree = "eza --tree";
      oo = "open .";
      pwdc = "pwd | pbcopy";
      flushdns = "sudo killall -HUP mDNSResponder";
      dotfiles = "cursor ~/.config/nixpkgs";
    };

    # User-specific shell init (will be combined with the common shellInit)
    shellInit = ''
      # Add any jonasschultheiss-specific shell init here
    '';
  };
}
