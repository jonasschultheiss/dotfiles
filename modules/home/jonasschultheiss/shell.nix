{pkgs, ...}: {
  # Temporarily removed common shell configuration import

  # Basic shell configuration
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

  # Basic starship prompt
  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_status$cmd_duration$line_break$character";

      # Common symbol settings
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };

      # Directory settings
      directory = {
        truncation_length = 5;
        truncation_symbol = "…/";
      };
    };
  };

  # Common packages for shell functionality
  home.packages = with pkgs; [
    fzf # Fuzzy finder
    zoxide # Smarter cd command
    fd # Modern find replacement
    bat # Modern cat replacement
    eza # Modern ls replacement
    ripgrep # Modern grep replacement
    jq # JSON processor
    htop # Better top
    tmux # Terminal multiplexer
  ];
}
