# Additional system settings for darwin
{
  config,
  pkgs,
  lib,
  ...
}: {
  # System-wide settings for nix
  nix = {
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

  # System defaults for macOS
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      orientation = "left";
      showhidden = true;
      show-recents = false;
      static-only = true;
      tilesize = 32;
      launchanim = false;
      mru-spaces = false;
    };

    # Finder settings
    finder = {
      AppleShowAllFiles = true;
      ShowPathbar = true;
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      CreateDesktop = false;
    };

    # Security and login settings
    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = true;
    };

    # Global domain settings
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      AppleShowAllExtensions = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
    };
  };
}
