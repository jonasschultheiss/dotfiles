{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./system.nix
    ./macos.nix
    ./homebrew.nix
    # ./aerospace.nix
  ];

  # Set the primary user for nix-darwin migration
  system.primaryUser = "jonasschultheiss";

  # These are the core settings that should be in the default darwin module
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };

    # Enable automatic store optimization
    optimise.automatic = true;

    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 3; Minute = 15; };
      options = "--delete-older-than 30d";
    };

    # Add ability to install packages for both Intel and ARM macs if needed
    extraOptions =
      lib.optionalString (pkgs.stdenv.hostPlatform.system == "aarch64-darwin") ''
        extra-platforms = aarch64-darwin x86_64-darwin
      ''
      + lib.optionalString (pkgs.stdenv.hostPlatform.system == "x86_64-darwin") ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
  };

  # Ensure Homebrew binaries are on the system PATH for all shells (including sudo)
  environment.systemPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/usr/local/bin"
    "/usr/local/sbin"
  ];

  # Fix for Nix build user group ID mismatch
  # This is needed when the nixbld group has GID 350 instead of the expected 30000
  ids.gids.nixbld = 350;

  # Including security settings directly from security.nix
  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;
}
