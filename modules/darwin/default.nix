{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./system.nix
    ./homebrew.nix
    ./macos.nix
  ];

  # These are the core settings that should be in the default darwin module
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };

    # Enable automatic store optimization
    optimise.automatic = true;

    # Add ability to install packages for both Intel and ARM macs if needed
    extraOptions =
      lib.optionalString (pkgs.system == "aarch64-darwin") ''
        extra-platforms = aarch64-darwin x86_64-darwin
      ''
      + lib.optionalString (pkgs.system == "x86_64-darwin") ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
  };

  # Fix for Nix build user group ID mismatch
  # This is needed when the nixbld group has GID 350 instead of the expected 30000
  ids.gids.nixbld = 350;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;
}
