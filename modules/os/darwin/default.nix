# Main darwin configuration module
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Enable nix command and flakes with dirty warning disabled
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false; # Disable the "Git tree is dirty" warning
  };

  # Enable auto-optimise-store
  nix.optimise.automatic = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable fish shell
  programs.fish.enable = true;
  environment.shells = with pkgs; [fish];

  # Set hostname and system version
  # This can be overridden by the user's configuration
  networking.hostName = lib.mkDefault "darwin-machine";
  system.stateVersion = 4;

  # Add basic system packages
  environment.systemPackages = with pkgs; [
    alejandra # Nix formatter
    git
  ];

  # Set default screencapture location
  # This is a sensible default that can be overridden
  system.defaults.screencapture.location = lib.mkDefault "~/Pictures/Screenshots";

  # Import additional system settings
  imports = [
    ./system.nix
  ];
}
