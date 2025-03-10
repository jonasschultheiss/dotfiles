# Shell configuration for jonasschultheiss
{pkgs, ...}: {
  # Enable fish shell
  programs.fish = {
    enable = true;

    # Shell aliases specific to jonasschultheiss
    shellAliases = {
      # Modern command-line tools
      git = "hub";
      ls = "eza";
      cat = "bat";
      find = "fd";

      # ls shortcuts
      l = "ls -l";
      ll = "ls -la";

      # Navigation shortcuts
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Common utilities
      tree = "eza --tree";
      reload = "exec fish";
      oo = "open .";
      pwdc = "pwd | pbcopy";
      flushdns = "sudo killall -HUP mDNSResponder";
      dotfiles = "cursor ~/.config/nixpkgs";
    };

    # Shell init
    shellInit = ''
      # Initialize homebrew
      eval (/opt/homebrew/bin/brew shellenv)

      # Disable fish greeting
      set -g fish_greeting ""

      # Add any jonasschultheiss-specific shell init here
    '';
  };
}
