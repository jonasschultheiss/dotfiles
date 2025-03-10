# Common shell configuration
{
  pkgs,
  lib,
  config,
  ...
}: {
  # Base fish shell configuration
  programs.fish = {
    enable = true;

    # Common shell aliases
    shellAliases = {
      # Common directory navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Common utilities
      reload = "exec fish";

      # For system rebuilding (more idiomatic with flakes)
      rebuild = "nix run .#build";
    };

    # Common shell initialization
    shellInit = ''
      # Disable fish greeting
      set -g fish_greeting ""

      # Initialize homebrew (common for macOS)
      if test -d /opt/homebrew
        eval (/opt/homebrew/bin/brew shellenv)
      end
    '';
  };

  # Common plugins
  programs.fish.plugins = [
    {
      name = "nix-env";
      src = pkgs.fetchFromGitHub {
        owner = "lilyball";
        repo = "nix-env.fish";
        rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
        sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
      };
    }
  ];
}
