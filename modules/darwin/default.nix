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
  networking.hostName = "jonasschultheiss-mac";
  system.stateVersion = 4;

  # Add basic system packages
  environment.systemPackages = with pkgs; [
    alejandra # Nix formatter
    git
  ];

  # Configure screenshot location for jonasschultheiss
  system.defaults.screencapture.location = "/Users/jonasschultheiss/Pictures/Screenshots";

  # Import additional system settings
  imports = [
    ./system.nix
  ];
}
